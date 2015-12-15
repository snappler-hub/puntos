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
#  available   :integer          default(0)
#

class PointsPeriod < ActiveRecord::Base

  # -- Scopes
  scope :not_in_progress, -> { where.not(status: PointsPeriod.statuses['in_progress']) }
  scope :recents, -> { order(created_at: :desc) }

  # -- Associations
  belongs_to :service, class_name: 'Service', foreign_key: 'service_id'

  # -- Validations
  validates :service, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :amount, presence: true
  validates :accumulated, presence: true

  # -- Callbacks
  after_update :update_available, if: Proc.new { |u| u.accumulated_changed? }
  after_update :update_user_cache_points, if: Proc.new { |u| u.available_changed? }

  # Statuses
  # in_progress: Período actual (default)
  # accomplished: Período cumplido
  # expired: Período vencido sin cumplir 
  # closed: Período cerrado manualmente 
  enum status: {in_progress: 0, accomplished: 1, expired: 2, closed: 3}

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
    self.service.create_period
  end

  # Reinicio el período reseteando los días y pongo el estado En Curso
  # Se verifica que el usuario no tenga otro servicio de puntos activo
  def restart
    return false unless self.service.can_be_activated?

    self.start_date = Date.today
    self.end_date = Date.today + (self.service.days).days
    self.status = :in_progress
    self.save
  end
  
  # Pongo los puntos disponibles en cero indicando que expiraron
  def expire_points
    self.available = 0
    self.save
  end

  #Actualizo los puntos acumulados
  def update_accumulated(points)
    self.accumulated += points
    self.save
  end

  def update_available
    new_points = accumulated - accumulated_was
    self.reload #Clear de los attribute_changes para que accumulated deje de aparecer como changed
    self.available += new_points
    self.save
  end

  def update_user_cache_points
    service.user.update_cache_points(available - available_was)
  end

end
