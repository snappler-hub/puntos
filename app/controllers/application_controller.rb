class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :require_login

  def admin
    # flash[:notice] = 'Probando Snackbar.'
    authorize! can_admin?
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

  def god?
    is? :god
  end

  def normal_user?
    is? :normal_user
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
      when 'admin'  then current_user.supplier || admin_path
      when 'seller' then admin_path
      else root_path
    end
  end
  helper_method :current_user_path

  def can_admin?
    is?(:god) || is?(:admin) || is?(:seller)
  end
  helper_method :can_admin?

  def is?(role)
    logged_in? && current_user.is?(role)
  end
end