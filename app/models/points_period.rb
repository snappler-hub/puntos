# == Schema Information
#
# Table name: points_periods
#
#  id          :integer          not null, primary key
#  service_id  :integer
#  start_date  :date
#  end_date    :date
#  status      :integer          default(0)
#  amount      :integer          default(0)
#  accumulated :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class PointsPeriod < ActiveRecord::Base
  
  # -- Associations
  belongs_to :service, class_name:  "Service", foreign_key: "service_id"
  
  # -- Validations
  validates :service, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :amount, presence: true
  validates :accumulated, presence: true
  
  # Statuses
  # in_progress: Período actual (default)
  # accomplished: Período cumplido
  # expired: Período vencido sin cumplir 
  enum status: { in_progress: 0, accomplished: 1, expired: 2 }
  
  # Marca el período y el servicio asociado como vencidos
  def mark_as_expired
    ActiveRecord::Base.transaction do
      self.status = :expired
      self.save
  
      self.service.mark_as_expired
    end
  end
  
  # True si el no llegó a cubrir los puntos del período
  def can_renew?
    self.accumulated >= self.amount 
  end
  
end
