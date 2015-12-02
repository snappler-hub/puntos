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
  validates :product, :amount, :accumulated, presence: true
  
  # -- Methods

  #Cantidad que resta para cumplir con el cupo del pfpc
  def remaining_amount
    if accumulated >= amount
      0
    else
      (amount - accumulated)
    end
  end
  
end