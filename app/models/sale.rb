# == Schema Information
#
# Table name: sales
#
#  id         :integer          not null, primary key
#  seller_id  :integer
#  client_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Sale < ActiveRecord::Base
  
  # -- Scopes
  default_scope -> { order('created_at DESC') }
  scope :all_sold_by, ->(user) { where(seller: user) }
  scope :all_sold_to, ->(user) { where(client: user) }
  
  # -- Associations
  has_many :sale_products, dependent: :destroy
  accepts_nested_attributes_for :sale_products, allow_destroy: true
  belongs_to :seller, class_name: 'User', foreign_key: "seller_id"
  belongs_to :client, class_name: 'User', foreign_key: "client_id"
  
  # -- Validations
  # validates :seller, presence: true
  # validates :client, presence: true
  
  # -- Methods
  def self.all_from_supplier(supplier)
    users = User.all_from_supplier(supplier)
    sales = []
    users.map do |user|
      user.sales.map do |sale|
        sales << sale
      end
    end
    return sales 
  end
  
end
