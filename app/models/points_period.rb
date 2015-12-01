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
  enum status: { in_progress: 0, accomplished: 1, expired: 2, closed: 3 }
  
  # Cambia el estado del periodo
  def mark_as(status)
    self.status = status
    self.save
  end
  
  # True si el cliente no llegó a cubrir los puntos del período
  def can_renew?
    self.accumulated >= self.amount 
  end
  
  # Renuevo el período 
  def renew
    # TODO Ver qué hace el renovar un período de un servicio de puntos
  end
  
  # Reinicio el período reseteando los días y pongo el estado En Curso
  def restart
    self.start_date = Date.today
    self.end_date = Date.today + (self.service.days).days
    self.state = :in_progress
    self.save
  end
  
end
