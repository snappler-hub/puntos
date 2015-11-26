# == Schema Information
#
# Table name: product_pfpcs
#
#  id         :integer          not null, primary key
#  product_id :integer
#  service_id :integer
#  amount     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProductPfpc < ActiveRecord::Base
  
  # -- Associations
  belongs_to :product
  belongs_to :service, class_name:  "PfpcService", foreign_key: "service_id"
  
  # -- Validations
  validates :product, presence: true
  validates :amount, presence: true
  validates :product, uniqueness: { scope: :service, message: 'ya está en uso. Verifique no tener productos repetidos' }
  
end
