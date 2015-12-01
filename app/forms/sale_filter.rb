class SaleFilter
  include ActiveModel::Model
  attr_accessor :seller, :client

  def call
    sales = Sale.all
    
    if @seller.present?
      case @seller.role
        when 'god'
          sales = Sale.all
        when 'admin'
          sales = Sale.all_from_supplier(@seller.supplier)
        when 'seller'
          sales = Sale.all_sold_by(@seller)
      end
    end
    
    sales = Sale.all_sold_to(@client) if @client.present?
    
    sales

  end
end