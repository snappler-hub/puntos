class UsersController < ApplicationController
  before_action :set_supplier
  before_action :set_user, only: [:show, :edit, :update, :destroy, :assign_card, :edit_points, :update_points]
  before_action :only_authorize_admin!, except: [:show, :edit, :update, :search]
  before_action :only_authorize_god!, only: [:edit_points, :update_points]

  # GET /users
  # GET /users.json
  def index
    @filter = UserFilter.new(filter_params)
    @users = @filter.call(current_user, @supplier).page(params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
    authorize!(admin_permission? || is_me?)
    if is_me? && normal_user?
      render layout: 'public'
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  def assign_card
    if @user.card_number.blank?
      CardManager.assign_card_number! @user
      redirect_to @user, notice: "Se asignó la tarjeta con número #{@user.card_number}"
    else
      redirect_to @user, alert: 'El usuario ya tiene tarjeta asignada'
    end
  end

  # GET /users/search
  def search
    block = lambda { |x| {name: x.card_number, id: x.id} }
    records = RecordSearcher.call(User.all, params, &block)
    render json: records.to_json, callback: params[:callback]
  end

  # GET /users/1/edit
  def edit
    authorize!(admin_permission? || is_me?)
    if is_me? && normal_user?
      render layout: 'public'
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.supplier = @supplier if @supplier
    @user.created_by = current_user if current_user
    respond_to do |format|
      ActiveRecord::Base.transaction do
        if @user.save
          CardManager.assign_card_number! @user if is?(:god)
          format.html { redirect_to [@supplier, @user], notice: 'El usuario ha sido creado correctamente.' }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    authorize!(admin_permission? || is_me?)
    respond_to do |format|
      if @user.update(user_params)
        retirect_path = is_me? ? profile_path : [@supplier, @user]
        format.html { redirect_to retirect_path, notice: 'El usuario ha sido actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if is_me?
      redirect_to [@supplier, :users], alert: 'No puede eliminarse a si mismo.'
    else
      respond_to do |format|
        if @user.destroy
          format.html { redirect_to [@supplier, :users], notice: 'El usuario ha sido eliminado correctamente. ' }
          format.json { head :no_content }
        else
          error = 'El usuario no ha podido eliminarse. Puede que tenga servicios, ventas o puntos asociados. '
          format.html { redirect_to [@supplier, :users], notice: error }
          format.json { render json: [error] } 
        end
      end
    end
  end
  
  # GET /users/1/change_points
  def edit_points
    render layout: nil
  end
  
  # GET /users/1/change_points
  def update_points
    @user.cache_points += params[:points_value].to_f
    @user.save!
    
    redirect_to [@supplier, @user], notice: 'Los puntos del usuario han sido modificados correctamente.' 
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    if request.original_fullpath == '/profile'
      @user = current_user
    elsif @supplier
      @user = @supplier.users.find(params[:id])
    else
      @user = User.find(params[:id])
    end
  end

  def set_supplier
    if params[:supplier_id]
      @supplier = Supplier.find(params[:supplier_id])
    end
  end

  def is_me?
    current_user == @user
  end

  # Un usuario no debe poder cambiar su propio +role+ ni +supplier+.
  def user_params
    permitted_params = [:email, :password, :password_confirmation, :first_name, :last_name, :username, :document_type, :document_number, :phone, :address, :image, :remove_image]
    permitted_params += [:role, :supplier_id] unless is_me?
    params.require(:user).permit(*permitted_params)
  end

  def filter_params
    params.require(:user_filter).permit(:email, :role, :card_number, :document_number, :card_state) if params[:user_filter]
  end
end