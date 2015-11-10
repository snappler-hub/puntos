class UsersController < ApplicationController
  before_action :set_supplier
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    if @supplier
      @users = @supplier.users
    else
      @users = User.all
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
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to [@supplier, @user], notice: 'El usuario ha sido actualizado correctamente.' }
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
      if @supplier
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :role, :first_name, :last_name, :supplier_id)
    end
end
