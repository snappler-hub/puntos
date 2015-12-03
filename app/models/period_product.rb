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
  # Se cambió 'belongs_to :service_period' por 'belongs_to :pfpc_period'
  belongs_to :pfpc_period
  belongs_to :product
  has_one :service, through: :pfpc_period
  has_one :user, through: :service

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
  
  def self.find_period(user, product)
    PeriodProduct.joins(:user).where(:users => {id: user}, product: product).first
  end
  
  def add_to_accumulated(amount)
    self.accumulated += amount
    self.save!
  end 
  
end