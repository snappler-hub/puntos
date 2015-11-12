class UsersController < ApplicationController
  before_action :set_supplier
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :only_authorize_admin!, except: [:edit, :update]

  # GET /users
  # GET /users.json
  def index
    if @supplier
      @users = @supplier.users
    else
      @users = User.includes(:supplier).all
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    authorize!(admin_permission? || is_me?)
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.supplier = @supplier if @supplier
    @user.created_by = current_user if current_user

    respond_to do |format|
      if @user.save
        format.html { redirect_to [@supplier, @user], notice: 'El usuario ha sido creado correctamente.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
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
    @user.destroy
    respond_to do |format|
      format.html { redirect_to [@supplier, :users], notice: 'El usuario ha sido eliminado correctamente.' }
      format.json { head :no_content }
    end
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
      if is_me?
        params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
      else
        params.require(:user).permit(:email, :password, :password_confirmation, :role, :first_name, :last_name, :supplier_id)
      end
    end
end