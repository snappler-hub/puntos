class PeriodProduct < ActiveRecord::Base

  # -- Associations
  belongs_to :service_period
  belongs_to :product

  # -- Validations
  validates :service_period, :product, :amount, :accumulated, presence: true

end