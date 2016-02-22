# == Schema Information
#
# Table name: product_discounts
#
#  id           :integer          not null, primary key
#  product_id   :integer
#  vademecum_id :integer
#  discount     :float(24)        default(0.0)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ProductDiscount < ActiveRecord::Base

  # -- Associations
  belongs_to :product
  belongs_to :vademecum
  belongs_to :coinsurance
  belongs_to :health_insurance

  # -- Validations
  validates :product_id, uniqueness: { scope: [:vademecum_id] }
  
  # -- Methods

end