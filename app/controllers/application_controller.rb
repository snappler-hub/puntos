class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :require_login

  def admin
  end

  def index
  end

  private

  def only_authorize_admin!
    authorize! admin_permission?
  end

  def only_authorize_god!
    authorize! is?(:god)
  end

  def authorize!(condition)
    unless condition
      flash[:warning] = 'No tienes los permisos necesarios para acceder a esta página.'
      redirect_to login_path
    end
  end

  def not_authenticated
    flash[:warning] = 'Debes autenticarte para acceder a esta página.'
    redirect_to login_path
  end

  def is?(role)
    logged_in? && current_user.is?(role)
  end

  def admin_permission?
    if @supplier
      is?(:admin) && (current_user.supplier == @supplier) || is?(:god)
    else
      is?(:god)
    end
  end

  def current_user_path
    case current_user.role
      when 'god'    then suppliers_path
      when 'admin'  then current_user.supplier || root_path
      when 'seller' then root_path
      else root_path
    end
  end
  helper_method :current_user_path

end