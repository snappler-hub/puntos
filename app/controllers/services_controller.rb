class ServicesController < ApplicationController

  before_action :set_supplier
  before_action :set_user
  before_action :set_service, only: [:show, :edit, :update, :destroy, :activate, :finalize, :history]
  before_action :only_authorize_god!, except: [:show, :near_expiration, :history]
  before_action :only_authorize_admin!, only: [:near_expiration]

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
    authorize!(admin_permission? || is_mine?)
    if is_mine? && normal_user?
      render layout: 'public'
    end
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

  # PUT /users/1/services/1/activate
  def activate
    ActiveRecord::Base.transaction do
      if @service.pending?
        unless @service.can_be_activated?
          flash[:error] = 'El servicio no puede ser activado.'
          redirect_to [@user, @service]
          return false
        else
          @service.last_period.restart
          @service.mark_as(:in_progress)
        end
      else
        @service.last_period.renew
      end
      @service.mark_as(:in_progress)
    end
    redirect_to [@user, @service], notice: 'El servicio ha sido activado.'
  end

  # PUT /users/1/services/1/finalize
  def finalize
    ActiveRecord::Base.transaction do
      @service.last_period.mark_as(:closed)
      @service.mark_as(:closed)
    end
    redirect_to [@user, @service], notice: 'El servicio ha sido finalizado.'
  end

  # GET /services/near_expiration
  # Muestra los servicios próximos a vencer
  def near_expiration
    @filter = NearExpirationFilter.new(filter_params)
    @services = @filter.call(@supplier).page(params[:page])
  end

  # GET /services/X/history
  # Muestra el historial de períodos
  def history
    authorize!(admin_permission? || is_mine?)
    @periods = @service.periods.not_in_progress.recents
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
    if params[:user_id]
      @user = User.find(params[:user_id])
    end
  end

  def set_supplier
    if params[:supplier_id]
      @supplier = Supplier.find(params[:supplier_id])
    end
  end

  def set_service
    @service = Service.find(params[:id])
  end

  def is_mine?
    current_user == @service.user
  end

  def service_params
    allowed_params = [:name, :days]

    if params[:service][:type] == 'PointsService'
      allowed_params << :amount << :days_to_points_expiration
    else
      allowed_params << :vademecum_id << [product_pfpcs_attributes: [:id, :product_id, :amount, :_destroy]]
    end

    params.require(:service).permit(allowed_params)
  end

  def filter_params
    params.require(:near_expiration_filter).permit(:supplier_id, :date) if params[:near_expiration_filter]
  end
end
