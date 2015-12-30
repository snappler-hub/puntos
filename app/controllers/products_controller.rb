class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :only_authorize_god!, only: [:index, :new, :create, :destroy]  

  # GET /products
  def index
    @filter = ProductFilter.new(filter_params)
    @products = @filter.call.page(params[:page])
  end
  
  # GET /products/search
  def search
    block = lambda { |record| { name: record.name, id: record.id, extra: record.code } }
    records = RecordSearcher.call(Product.all, params, &block)
    render json: records.to_json, callback: params[:callback]
  end

  # GET /products/1
  def show
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
    products_for_search = Product.products_for_service(params[:vademecum_id], user)
    records = RecordSearcher.call(products_for_search, params)
    render json: records.to_json, callback: params[:callback]
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :code, :points, 
          supplier_point_products_attributes: [:id, :points, :supplier_id, :_destroy])
    end

    def filter_params
      if params[:product_filter]
        params.require(:product_filter).permit(:name, :laboratory_id, :drug_id)
      end
    end
  
end