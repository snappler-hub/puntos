class SaleFilter
  include ActiveModel::Model
  attr_accessor :supplier_id, :seller_id, :client_id, :start_date, :finish_date

  def call
    sales = Sale.all
    
    # if @seller.present?
    #   case @seller.role
    #     when 'god'
    #       sales = Sale.all
    #     when 'admin'
    #       sales = Sale.all_from_supplier(@seller.supplier)
    #     when 'seller'
    #       sales = Sale.all_sold_by(@seller)
    #   end
    # end
    sales = sales.all_from_supplier(@supplier_id) if @supplier_id.present?
    sales = sales.where("seller_id = ?", @seller_id) if @seller_id.present?
    sales = sales.where("client_id = ?", @client_id) if @client_id.present?
    sales = sales.between_dates(@start_date, @finish_date) if @start_date.present?
    
    sales

  end
  
  def client
    if @client_id.present?
      User.find(@client_id)
    end
  end
  
  def card_number
    client.card_number if client.present?
  end
  
  def supplier?
    @supplier_id
  end
  
  def seller?
    @seller_id
  end
    
end