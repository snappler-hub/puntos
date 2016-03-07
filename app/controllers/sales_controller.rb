class SalesController < ApplicationController
  before_action :set_sale, only: [:show]
  before_action :set_supplier
  before_action :only_authorize_admin!, except: [:index, :show]

  # GET users/1/sales
  def index
    @filter = SaleFilter.new(filter_params)
    @sales = @filter.call(current_user).page(params[:page])

    respond_to do |format|
      format.html {
        render layout: 'public' if normal_user?
      }
      format.xlsx
    end
  end

  #GET users/1/sales/1
  def show
    if normal_user?
      render 'show', layout: 'public'
    end
  end

  # GET users/1/sales/new
  def new
    @sale = Sale.new
  end

  # POST users/1/sales
  # Recibe el id de una autorización por parámetro, y crea una venta.
  def create
    authorization = Authorization.find(params[:authorization])
    if authorization.created_at > Const::AUTHORIZATION_EXPIRATION_LIMIT.minutes.ago
      manager = SaleFromAuthorization.new(authorization)
      @sale = manager.create
      redirect_to [current_user.supplier, current_user, @sale], notice: 'La venta ha sido creada correctamente.'
    else
      render text: 'La autorización ha expirado'
    end
  end

  def destroy
    #Charlar si es necesario
  end

  def edit
    #Charlar si es necesario
  end

  private

  def set_sale
    @sale = Sale.find(params[:id])
  end

  def sale_params
    params.require(:sale).permit(:seller_id, :client_id, :health_insurance_id, :coinsurance_id, sale_products_attributes: [:id, :product_id, :amount, :cost, :discount, :client_points, :seller_points, :_destroy])
  end

  def filter_params
    if params[:sale_filter]
      params.require(:sale_filter).permit(:supplier_id, :seller_id, :client_id, :start_date, :finish_date, :laboratory_id, :drug_id)
    end
  end

  def set_supplier
    @supplier = current_user.supplier
  end

end