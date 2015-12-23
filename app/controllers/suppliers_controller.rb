class SuppliersController < ApplicationController
  before_action :set_supplier, only: [:show, :edit, :update, :destroy]
  before_action :only_authorize_god!, only: [:index, :new, :create, :destroy]
  before_action :only_authorize_admin!, only: [:show, :edit, :update]

  # GET /suppliers
  # GET /suppliers.json
  def index
    @filter = SupplierFilter.new(filter_params)
    @suppliers = @filter.call.page(params[:page])
  end

  # GET /suppliers/1
  # GET /suppliers/1.json
  def show
  end

  # GET /suppliers/new
  def new
    @current_supplier = Supplier.new
  end

  # GET /suppliers/1/edit
  def edit
    @current_supplier = Supplier.find(params[:id])
  end

  # POST /suppliers
  # POST /suppliers.json
  def create
    @supplier = Supplier.new(supplier_params)

    respond_to do |format|
      if @supplier.save
        format.html { redirect_to @supplier, notice: 'El prestador ha sido creado correctamente.' }
        format.json { render :show, status: :created, location: @supplier }
      else
        format.html { render :new }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /suppliers/1
  # PATCH/PUT /suppliers/1.json
  def update
    respond_to do |format|
      if @supplier.update(supplier_params)
        format.html { redirect_to @supplier, notice: 'El prestador ha sido actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @supplier }
      else
        format.html { render :edit }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /suppliers/1
  # DELETE /suppliers/1.json
  def destroy
    @supplier.destroy ? flash[:success] = 'El Prestador ha sido eliminado correctamente.' : flash[:error] = 'No se pudo eliminar el Prestador seleccionado.'
    respond_to do |format|
      format.html { redirect_to suppliers_url }
      format.json { head :no_content }
    end
  end

  # GET /suppliers/list_for_map
  def list_for_map
    @suppliers = Supplier.with_location.in_bounds([params[:sw], params[:ne]])
    @center_point = Geocoder::Calculations.geographic_center(@suppliers)

    respond_to do |format|
      format.js
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_supplier
    @supplier = Supplier.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def supplier_params
    if god?
      params.require(:supplier).permit(:name, :description, :active, :address, :latitude, :longitude, :telephone,
                                       :email, :points_to_client, :points_to_seller, :contact_info,
                                       supplier_point_products_attributes: [:id, :points, :product_id, :_destroy],
                                       vademecum_ids: [])
    else
      params.require(:supplier).permit(:name, :description)
    end
  end

  def filter_params
    params.require(:supplier_filter).permit(:name, :state) if params[:supplier_filter]
  end
end