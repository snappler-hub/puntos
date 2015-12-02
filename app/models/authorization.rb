class Authorization < ActiveRecord::Base
  
  serialize :products, Array
  
  # -- Scopes
  default_scope -> { order('created_at DESC') }
  
  # -- Associations
  belongs_to :seller, class_name: 'User', foreign_key: "seller_id"
  belongs_to :client, class_name: 'User', foreign_key: "client_id"
  
  # -- Validations
  # validates :seller, presence: true
  # validates :client, presence: true
  
  # -- Methods
  def ok?
    status == 'OK'
  end
end
