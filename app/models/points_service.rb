# == Schema Information
#
# Table name: services
#
#  id                        :integer          not null, primary key
#  name                      :string(255)      not null
#  type                      :string(255)      not null
#  user_id                   :integer
#  last_period_id            :integer
#  amount                    :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  days                      :integer          default(30)
#  vademecum_id              :integer
#  status                    :integer          default(0)
#  days_to_points_expiration :integer
#

class PointsService < Service

  # -- Associations
  has_many :periods, class_name: 'PointsPeriod', foreign_key: 'service_id', dependent: :destroy
  belongs_to :last_period, class_name: 'PointsPeriod', foreign_key: 'last_period_id'

  # -- Validations
  validates :amount, presence: true

  # -- Callbacks
  after_create :create_period

  # -- Methods
  def self.model_name
    superclass.model_name
  end

  # Creo un período y lo asigno como último del servicio
  def create_period
    period = self.periods.create do |period|
      period.start_date = Date.today
      period.end_date = Date.today + (self.days).days
      period.amount = self.amount
      period.accumulated = 0
    end

    self.update(last_period: period)

    period
  end

  # True si no existe otro servicio de puntos activo para el usuario
  def can_be_activated?
    !PointsService.where.not(id: self.id).exists?(user: user, status: 'in_progress')
  end

end