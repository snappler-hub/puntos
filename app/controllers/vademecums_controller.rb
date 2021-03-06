class VademecumsController < ApplicationController
  before_action :set_vademecum, only: [:show, :edit, :update, :destroy, :get_suppliers]
  before_action :only_authorize_god!, only: [:index, :new, :create, :destroy]

  # GET /vademecums
  def index
    @vademecums = Vademecum.all.page(params[:page])
  end

  # GET /vademecums/1
  def show
  end

  # GET /vademecums/new
  def new
    @vademecum = Vademecum.new
  end

  # GET /vademecums/1/edit
  def edit
  end

  # POST /vademecums
  def create
    @vademecum = Vademecum.new(vademecum_params)

    respond_to do |format|
      if @vademecum.save
        format.html { redirect_to vademecums_path, notice: 'El vademecum ha sido creado correctamente.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /vademecums/1
  def update
    respond_to do |format|
      if @vademecum.update(vademecum_params)
        format.html { redirect_to vademecums_path, notice: 'El vademecum ha sido actualizado correctamente.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /vademecums/1
  def destroy
    if @vademecum.destroy
      flash[:notice] = 'El Vademecum ha sido eliminado correctamente.'
    else
      if @vademecum.pfpc_services.empty?
        flash[:error] = 'No se pudo eliminar el Vademecum seleccionado.'
      else
        flash[:error] = 'No se pudo eliminar el Vademecum seleccionado ya que hay servicios PFPC asociados.'
      end
    end
    redirect_to vademecums_path
  end
  
  def get_suppliers
    @user = current_user
    @service = PfpcService.new(suppliers: @vademecum.suppliers)
    respond_to do |format|
      format.js
    end
  end

  private

  def set_vademecum
    @vademecum = Vademecum.find(params[:id])
  end

  def vademecum_params
    params.require(:vademecum).permit(:name, [product_discounts_attributes: [:id, :product_id, :health_insurance_id, :coinsurance_id, :discount, :health_insurance_discount, :coinsurance_discount, :health_insurance_and_coinsurance_discount, :_destroy]], supplier_ids: [])
  end

end