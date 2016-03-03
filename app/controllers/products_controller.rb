class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update, :destroy]
  before_action :only_authorize_god!, only: [:index, :new, :create, :destroy]

  # GET /products
  def index
    @filter = ProductFilter.new(filter_params)
    @products = @filter.call.page(params[:page])
  end

  # GET /products/search
  def search
    block = lambda { |record| {
        id: record.id,
        name: record.name,
        price: record.price,
        laboratory: record.laboratory.to_s,
        barcode: record.barcode || '-',
        troquel_number: record.troquel_number || '-',
        extra: "<dl>
                    <dt>Presentación</dt>
                    <dd>#{record.presentation_form}</dd>
                    <dt>Monodroga</dt>
                    <dd>#{record.drug.blank? ? 'NA' : record.drug.name}</dd>
                    <dt>Laboratorio</dt>
                    <dd>#{record.laboratory.name}</dd>
                    <dt>Código</dt>
                    <dd>#{record.code}</dd>
                </dl>"
    } }
    records = RecordSearcher.call(Product.all.includes(:laboratory, :drug).references(:drug), params, &block)
    render json: records.to_json, callback: params[:callback]
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  def create
    @product = Product.new(product_params)
    respond_to do |format|
      if @product.save
        format.html { redirect_to products_path, notice: 'El producto ha sido creado correctamente.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /products/1
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to products_path, notice: 'El producto ha sido actualizado correctamente.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'El producto ha sido eliminado correctamente.' }
    end
  end

  # GET /products/search_for_service.json
  # Retorna los productos que no están en ningún servicio del usuario (params[:user_id])
  # que cumplen con la búsqueda
  def search_for_service
    user = User.find(params[:user_id])
    products_for_search = Product.includes(:laboratory, :drug).products_for_service(params[:vademecum_id], user)
    records = RecordSearcher.call(products_for_search, params)
    render json: records.to_json, callback: params[:callback]
  end

  def new_batch_update
  end

  def batch_update
    Product.points_batch_update(params[:client_points], params[:seller_points], params[:laboratory_id])
    redirect_to products_path, notice: 'Se han actualizado los productos'
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :code, :barcode, :troquel_number, :client_points, :seller_points,
                                    supplier_point_products_attributes: [:id, :points, :supplier_id, :_destroy])
  end

  def filter_params
    if params[:product_filter]
      params.require(:product_filter).permit(:name, :laboratory_id, :drug_id)
    end
  end

end
