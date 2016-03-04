# == Schema Information
#
# Table name: services
#
#  id                        :integer          not null, primary key
#  name                      :string(255)      not null
#  type                      :string(255)      not null
#  user_id                   :integer
#  last_period_id            :integer
#  amount                    :float(24)
#  status                    :integer          default(0)
#  days                      :integer          default(30)
#  days_to_points_expiration :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  vademecum_id              :integer
#

class Service < ActiveRecord::Base

  # -- Scopes
  default_scope { order(:name) }
  scope :in_progress, -> { where(status: Service.statuses['in_progress']) }
  scope :pending, -> { where(status: Service.statuses['pending']) }
  scope :available, -> { where(status: [Service.statuses['pending'], Service.statuses['in_progress']]) }

  # -- Constants
  TYPES = %w(points pfpc seller)

  # -- Associations
  belongs_to :user

  # -- Validations
  validates :name, :user, :days, presence: true

  # Statuses
  # pending: Servicio creado pero no habilitado (default)
  # in_progress: En curso
  # expired: Servicio vencido. No se cumplió el objetivo en el último período
  # closed: Servicio cerrado/deshabilitado manualmente
  enum status: {pending: 0, in_progress: 1, expired: 2, closed: 3}

  def to_s
    name
  end

  # Cambia el estado del servicio
  def mark_as(status)
    self.status = status
    self.save
  end

  def can_be_activated?
    true
  end

end
