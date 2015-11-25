# == Schema Information
#
# Table name: service_periods
#
#  id         :integer          not null, primary key
#  service_id :integer
#  start_date :date
#  end_date   :date
#  status     :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ServicePeriod < ActiveRecord::Base
  
  # -- Associations
  belongs_to :service, class_name:  "ServicePfpc", foreign_key: "service_id"
  has_many :period_products, dependent: :destroy
  
  # -- Validations
  validates :service, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  
  # -- Misc
  enum status: { in_progress: 0, finished: 1 }
  
end
