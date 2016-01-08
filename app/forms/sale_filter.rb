class SaleFilter
  include ActiveModel::Model
  attr_accessor :supplier_id, :seller_id, :client_id, :start_date, :finish_date, :laboratory_id, :drug_id, :laboratory_name, :drug_name

  def call(current_user = nil)
    
    if current_user
      case current_user.role
        when 'god'
          sales = Sale.all
        when 'admin'
          sales = Sale.all_from_supplier(current_user.supplier.id)
        when 'seller'
          sales = Sale.where(seller: current_user)
        else
          sales = Sale.where(client: current_user)
      end
    end

    sales = sales.between_dates(@start_date, @finish_date) if @start_date.present?    
    sales = sales.all_from_supplier(@supplier_id) if @supplier_id.present?
    sales = sales.where("seller_id = ?", @seller_id) if @seller_id.present?
    sales = sales.where("client_id = ?", @client_id) if @client_id.present?
    
    if @laboratory_id.present?
      sales = sales.joins(:sale_products)
      sales = sales.joins("INNER JOIN products ON (products.id = sale_products.product_id)").where('laboratory_id = ?', @laboratory_id) 
      @laboratory_name = Laboratory.find(@laboratory_id).try(:name)
    end
    if @drug_id.present?
      sales = sales.joins(:sale_products)
      sales = sales.joins("INNER JOIN products ON (products.id = sale_products.product_id)").where('drug_id = ?', @drug_id) 
      @drug_name = Drug.find(@drug_id).try(:name)
    end
    
    sales.uniq

  end
  
  def client
    if @client_id.present?
      User.find(@client_id)
    end
  end
  
  def seller
    if @seller_id.present?
      User.find(@seller_id)
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
  
  def start_date?
    @start_date
  end
    
end