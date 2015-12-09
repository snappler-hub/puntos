class SalesController < ApplicationController
  before_action :set_sale, only: [:show]
  before_action :set_supplier
  before_action :only_authorize_admin!, except: [:sales_with_me_as_client]

  # GET users/1/sales
  def index
    @filter = SaleFilter.new(filter_params)
    @sales = Kaminari.paginate_array(@filter.call(current_user).to_a).page(params[:page])
    redirect_to "sales_with_me_as_client" if normal_user?
  end
  
  # GET
  def sales_with_me_as_client
    @filter = SaleFilter.new(filter_params)
    @sales = Kaminari.paginate_array(@filter.call(current_user).to_a).page(params[:page])
    render "index", layout: "public"
  end
    
  #GET users/1/sales/1
  def show
  end

  # GET users/1/sales/new
  def new
    @sale = Sale.new
    @products = Product.all
  end
  
  # POST users/1/sales
  # Recibe el id de una autorización por parámetro, y crea una venta.
  def create
    authorization = Authorization.find(params[:authorization])
    # TODO Meter horas en constante
    if authorization.created_at > 2.hours.ago 
      manager = SaleFromAuthorization.new(authorization)
      @sale = manager.create
      # TODO Ver qué devuelve tras la venta
      render "show" 
    else
      # TODO Definir qué se muestra cuando la autorización expiró
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
    params.require(:sale).permit(:seller_id, :client_id, sale_products_attributes:[:id, :product_id, :amount, :cost, :discount, :_destroy])
  end
  
  def filter_params
    if params[:sale_filter]
      params.require(:sale_filter).permit(:supplier_id, :seller_id, :client_id, :start_date, :finish_date)
    end
  end
  
  def set_supplier
    @supplier = current_user.supplier
  end
  
end