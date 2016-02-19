# == Schema Information
#
# Table name: sale_products
#
#  id         :integer          not null, primary key
#  product_id :integer
#  sale_id    :integer
#  amount     :integer          default(0)
#  cost       :float(24)        default(0.0)
#  discount   :float(24)        default(0.0)
#  created_at :datetime
#  updated_at :datetime
#  total      :float(24)        default(0.0)
#

class SaleProduct < ActiveRecord::Base

  # -- Scopes

  # -- Associations
  belongs_to :sale
  belongs_to :product
  belongs_to :health_insurance
  belongs_to :coinsurance

  # -- Validations
  validates :product_id, presence: true
  validates :amount, presence: true
  validates :cost, presence: true
  validates :discount, presence: true

  # -- Methods

end
