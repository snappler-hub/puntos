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
  
  # -- Associations
  has_many :sale_products, dependent: :destroy
  accepts_nested_attributes_for :sale_products, allow_destroy: true
  belongs_to :seller, class_name: 'User', foreign_key: "seller_id"
  belongs_to :client, class_name: 'User', foreign_key: "client_id"
  
  # -- Validations
  # validates :seller, presence: true
  # validates :client, presence: true
  
  # -- Methods
  
end
