class ServicePeriod < ActiveRecord::Base
  
  # -- Associations
  belongs_to :service
  has_many :period_products
  
  # -- Validations
  validates :service, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  
  # -- Misc
  enum status: { in_progress: 0, finished: 1 }
  
end
