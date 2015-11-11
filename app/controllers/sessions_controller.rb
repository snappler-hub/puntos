class SessionsController < ApplicationController

  skip_before_action :require_login, only: [:login_form, :create]

  def login_form
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to(current_user_path, notice: 'Ha iniciado sesión correctamente.')
    else
      flash.now[:alert] = 'Ocurrió un error al intentar iniciar sesión.'
      render action: 'login_form'
    end
  end

  def destroy
    logout
    redirect_to(:login, notice: 'Ha abandonado el sistema correctamente.')
  end

  private

  def current_user_path
    case current_user.role
      when 'god'    then suppliers_path
      when 'admin'  then current_user.supplier || root_path
      when 'seller' then root_path
      else root_path
    end
  end

end