class PeriodProduct < ActiveRecord::Base

  # -- Associations
  belongs_to :service_period
  belongs_to :product
  
  # -- Validations
  validates :service_period, presence: true
  validates :product, presence: true
  validates :amount, presence: true
  validates :accumulated, presence: true

end
