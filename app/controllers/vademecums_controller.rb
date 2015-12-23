class VademecumsController < ApplicationController
  before_action :set_vademecum, only: [:show, :edit, :update, :destroy]
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
    respond_to do |format|
      if @vademecum.destroy
        format.html { redirect_to vademecums_path, notice: 'El vademecum ha sido actualizado correctamente.' }
      else
        format.html { render :edit }
      end
    end




    @vademecum.destroy
    respond_to do |format|
      format.html { redirect_to vademecums_url, notice: 'El vademecum ha sido eliminado correctamente.' }
    end
  end

  private

    def set_vademecum
      @vademecum = Vademecum.find(params[:id])
    end

    def vademecum_params
      params.require(:vademecum).permit(:name, [product_discounts_attributes:[:id, :product_id, :discount, :_destroy]],
            supplier_ids: [])
    end
    
end