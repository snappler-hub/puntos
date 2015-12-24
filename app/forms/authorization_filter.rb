class AuthorizationFilter
  include ActiveModel::Model
  attr_accessor :id, :status, :client_id, :seller_id, :start_date, :finish_date, :supplier_id

  def call
    authorizations = Authorization.all.order(:created_at)
    authorizations = authorizations.where('id LIKE ?', "%#{@id}%") if @id.present?
    authorizations = authorizations.where(status: @status) if @status.present?
    authorizations = authorizations.where(client_id: @client_id ) if @client_id.present?
    authorizations = authorizations.where(seller_id: @seller_id ) if @seller_id.present?
    authorizations = authorizations.between_dates(@start_date, @finish_date) if @start_date.present?
    authorizations
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
  
  def supplier
    if @supplier_id.present?
      Supplier.find(@supplier_id)
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
  
  def finish_date?
    @finish_date
  end
  
  def client?
    @client_id
  end 
  
end