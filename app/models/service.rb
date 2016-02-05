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
#  always_discount           :boolean          default(FALSE)
#

class Service < ActiveRecord::Base

  # -- Scopes
  default_scope { order(:name) }
  scope :in_progress, -> { where(status: Service.statuses['in_progress']) }
  scope :pending, -> { where(status: Service.statuses['pending']) }

  # -- Constants
  TYPES = %w(points pfpc)

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
