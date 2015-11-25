class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update, :destroy]

  # GET user_id/sales
  def index
    @sales = Sale.where(seller: current_user)
  end
  
  def new
    @user = current_user
    @sale = Sale.new
    @products = Product.all
  end
  
  def create
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
  
end