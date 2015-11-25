class ServicePeriod < ActiveRecord::Base

  # -- Associations
  belongs_to :service
  has_many :period_products

  # -- Validations
  validates :service, :start_date, :end_date, presence: true

  # -- Misc
  enum status: { in_progress: 0, finished: 1 }

end