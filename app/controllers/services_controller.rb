class ServicesController < ApplicationController
  
  before_action :set_user
  before_action :set_service, only: [:show, :edit, :update, :destroy, :activate]
  before_action :only_authorize_god!
  
  # GET /users/X/services/new
  def new
    @service = build_service
  end
  
  # POST /users/X/services/new
  def create
    @service = build_service(service_params)
    @service.user = @user

    respond_to do |format|
      if @service.save
        format.html { redirect_to [@user, @service], notice: 'El servicio ha sido creado correctamente.' }
      else
        format.html { render :new }
      end
    end
  end
  
  # GET /users/2/services/1
  def show
  end
  
  # GET /users/2/services/1/edit
  def edit
  end
  
  # GET /users/2/services/1/edit_products
  def edit_products
  end
  
  # PATCH/PUT /users/2/services/1
  def update    
    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to [@user, @service], notice: 'El servicio ha sido actualizado correctamente.' }
      else
        format.html { render :edit }
      end
    end
  end
  
  # DELETE /users/1/services/1
  def destroy
    @service.destroy
    respond_to do |format|
      format.html { redirect_to @user, notice: 'El servicio ha sido eliminado correctamente.' }
    end
  end
  
  # PUT /
  def activate
    @service.create_period
    redirect_to [@user, @service], notice: 'El servicio ha sido activado.'
  end
  
  private
  
    def build_service(parameters=nil)
      if params[:type]
        params[:type] == 'pfpc' ? PfpcService.new(parameters) : PointsService.new(parameters)
      else
        params[:service][:type] == 'PointsService' ? PointsService.new(parameters) : PfpcService.new(parameters)
      end
    end
  
    def set_user
      @user = User.find(params[:user_id]) 
    end
  
    def set_service
      @service = Service.find(params[:id])
    end
  
    def service_params
      allowed_params = [:name, :days]
    
      if params[:service][:type] == 'PointsService'
        allowed_params << :amount 
      else
        allowed_params << :vademecum_id << [product_pfpcs_attributes:[:id, :product_id, :amount, :_destroy]]
      end

      params.require(:service).permit(allowed_params)
    end
    
end
