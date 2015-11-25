class ServicePeriod < ActiveRecord::Base
  
  # -- Associations
  belongs_to :service
  has_many :period_products
  
  # -- Validations
  validates :service, pesence: true
  validates :start_date, pesence: true
  validates :end_date, pesence: true
  
  # -- Misc
  enum status: { in_progress: 0, finished: 1 }
  
end
