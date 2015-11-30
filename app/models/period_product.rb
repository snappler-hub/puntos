# == Schema Information
#
# Table name: period_products
#
#  id             :integer          not null, primary key
#  pfpc_period_id :integer
#  product_id     :integer
#  amount         :integer
#  accumulated    :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class PeriodProduct < ActiveRecord::Base

  # -- Associations
  belongs_to :service_period
  belongs_to :product

  # -- Validations
  validates :service_period, :product, :amount, :accumulated, presence: true

end