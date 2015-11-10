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

  def not_authenticated
    flash[:warning] = 'Debes autenticarte para acceder a esta página.'
    redirect_to login_path
  end

end