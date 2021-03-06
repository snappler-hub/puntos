class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_shop_cart
  before_filter :require_login
  before_filter :should_accept_terms_of_use!
  before_filter :supplier_is_active!
  
  rescue_from RequestExceptions::BadRequestError, with: :bad_request
  rescue_from RequestExceptions::ForbiddenError, with: :forbidden
  rescue_from RequestExceptions::UnauthorizedError, with:  :unauthorized

  def admin
    # flash[:notice] = 'Probando Snackbar.'
    authorize! can_admin?
  end

  def current_shop_cart
    ShopCart::new(session)
  end
  
  # REQUEST ERRORS
  def bad_request (exception)    
    @message = exception.message
    respond_to do |f|
      flash.now[:error] = @message

      f.json { render 'common/error', layout: false, status: 400 }
      f.js { render 'common/error', layout: false, status: 400 }
      f.html do
        redirect_to root_url
      end
    end
  end

  def forbidden (exception)   
    @message = exception.message
    respond_to do |f|
      f.json { render 'common/error', layout: false, status: 401 }
      f.js { head 401 }
      f.html do
        flash[:error] = @message         
        redirect_to root_url
      end
    end
    return  
  end

  def unauthorized (exception)   
    @message = exception.message
    respond_to do |f|
      f.json { render 'common/error', layout: false, status: 403 }
      f.js { render 'common/error', layout: false, status: 403 }
      f.html do
        flash[:error] = @message
        redirect_to root_url
      end
    end
    return   
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
      is?(:admin) && (current_user.supplier == @supplier) || is?(:seller) && (current_user.supplier == @supplier) || is?(:god)
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
  
  def should_accept_terms_of_use!
    if should_accept_terms_of_use?
      redirect_to terms_of_use_path
    end
  end
  
  def should_accept_terms_of_use?
    logged_in? && current_user.card_number && !current_user.terms_accepted?
  end
  helper_method :should_accept_terms_of_use?
  
  def supplier_is_active!
    if is?(:admin) || is?(:seller)
      unless supplier_is_active?
        redirect_to login_path
      end
    end
  end
  
  def supplier_is_active?
     current_user.supplier.active?
  end
  helper_method :supplier_is_active_for_administration?
  
end