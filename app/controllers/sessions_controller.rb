class SessionsController < ApplicationController

  skip_before_action :require_login, only: [:login_form, :create]
  skip_before_action :should_accept_terms_of_use!
  skip_before_action :supplier_is_active!

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

end