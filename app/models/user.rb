# == Schema Information
#
# Table name: users
#
#  id                              :integer          not null, primary key
#  email                           :string(255)      not null
#  username                        :string(255)
#  role                            :string(255)
#  first_name                      :string(255)
#  last_name                       :string(255)
#  supplier_id                     :integer
#  number                          :integer
#  document_type                   :string(255)
#  document_number                 :string(255)
#  phone                           :string(255)
#  address                         :string(255)
#  card_number                     :string(255)
#  string                          :string(255)
#  terms_accepted                  :boolean          default(FALSE)
#  card_printed                    :boolean          default(FALSE)
#  card_delivered                  :boolean          default(FALSE)
#  cache_points                    :integer          default(0)
#  image_uid                       :string(255)
#  image_name                      :string(255)
#  created_by_id                   :integer
#  crypted_password                :string(255)
#  salt                            :string(255)
#  remember_me_token               :string(255)
#  remember_me_token_expires_at    :datetime
#  reset_password_token            :string(255)
#  reset_password_token_expires_at :datetime
#  reset_password_email_sent_at    :datetime
#  created_at                      :datetime
#  updated_at                      :datetime
#  supplier_request_id             :integer
#

class User < ActiveRecord::Base
  authenticates_with_sorcery!

  dragonfly_accessor :image

  ROLES = %w(god admin seller normal_user)
  DOCUMENT_TYPES = %w(dni cuil passport)

  # -- Callbacks
  # Al crear un usuario, le mando mail de bienvenida para que acepte términos y condiciones
  after_create :send_mail, if: Proc.new { |u| !u.terms_accepted? }

  # -- Scopes
  scope :search, ->(q) { where('card_number LIKE :q', q: "%#{q}%") }
  scope :with_role, ->(role) { where(role: role) }
  scope :all_from_supplier, ->(supplier) { where('supplier_id = ? AND role != ?', supplier.id, 'normal_user') }
  scope :sellers, -> { where.not(role: 'normal_user') }

  # -- Associations
  belongs_to :supplier
  belongs_to :created_by, class_name: 'User'
  has_many :services, dependent: :destroy
  has_many :pfpc_services
  has_many :sales, foreign_key: :seller_id
  has_many :points_services
  has_many :points_periods, through: :points_services, source: :periods

  # -- Validations
  validates :first_name, :last_name, :supplier, :document_type, :document_number, presence: true
  validates :password, confirmation: true
  validates :role, inclusion: {in: ROLES}
  validates :document_type, inclusion: {in: DOCUMENT_TYPES}
  validates :email, uniqueness: true
  validates :document_number, uniqueness: {scope: :document_type}

  def self.visible_sellers_for(user)
    return [] if user.is? :normal_user
    user.is?(:god) ? User.sellers : User.all_from_supplier(user.supplier)
  end

  def to_s
    fullname
  end

  def fullname
    "#{first_name} #{last_name}"
  end

  def is?(a_role)
    a_role.to_s == role
  end

  def to_param
    "#{id}-#{first_name}-#{last_name}".parameterize
  end

  def vademecums # TODO: and service is active
    pfpc_services.available.map &:vademecum
  end

  def accept_terms_of_use
    User.transaction do
      CardManager.accept_terms_of_use!(self)
    end
  end

  def activate_pending_services
    pfpc_services.pending.map { |serv| serv.update(status: Service.statuses['in_progress']) }
  end

  def can_view?(resource)
    resource.can_be_viewed_by?(self)
  end

  def pfpc_current_periods
    pfpc_services.collect { |pfpc| pfpc.last_period }
  end

  def update_cache_points(points)
    self.cache_points += points
    self.save
  end

  def has_points_service?
    points_services.count > 0 && points_services.first.in_progress?
  end

  def active_points_service
    self.points_services.in_progress.first
  end

  # Resta los puntos del usuario. Va sacando los disponibles
  # desde el período más viejo al más nuevo.
  def decrease_points(points)
    return false unless self.cache_points >= points # Alcanzan los puntos?

    periods = self.points_periods.where('points_periods.available > 0').order('points_periods.end_date')
    periods.each do |period|
      if period.available >= points
        period.update_attribute(:available, period.available-points)
        points = 0
        break
      else
        points -= period.available
        period.update_attribute(:available, 0)
      end
    end

    self.update_attribute(:cache_points, self.reload.cache_points-points) unless points == 0
  end

  def send_mail
    title = 'Bienvenido al sistema Manes'
    message = 'Para poder operar, es necesario que acepte los términos y condiciones. Para ello, haga clic en el siguiente botón e ingrese con su usuario y contraseña. '
    UserMailer.new_mail(self, title, message)
  end

end
