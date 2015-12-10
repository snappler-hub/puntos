class AuthorizationsController < ApplicationController
  before_action :set_authorization, only: [:show]
  
  #GET authorizations/1
  def show
  end

  # GET /authorizations
  def index
    @authorizations = Authorization.all
  end
  
  # POST /authorizations
  def create
    # Recibe los datos de una venta por parámetro (la venta no existe todavía), y crea una autorizacion.
    sale = Sale.new(sale_params)
    manager = AuthorizationFromSale.new(sale, current_user)
    @authorization = manager.authorize!
    @supplier = current_user.supplier
    respond_to do |format|
      format.js
    end
  end
  
  private

  def set_authorization
    @authorization = Authorization.find(params[:id])
  end
  
  def sale_params
    params.require(:sale).permit(:seller_id, :client_id, sale_products_attributes:[:id, :product_id, :amount, :cost, :discount, :_destroy])
  end  
  
end