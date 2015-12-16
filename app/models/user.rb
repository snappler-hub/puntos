# == Schema Information
#
# Table name: users
#
#  id                              :integer          not null, primary key
#  email                           :string(255)      not null
#  crypted_password                :string(255)
#  salt                            :string(255)
#  role                            :string(255)
#  first_name                      :string(255)
#  last_name                       :string(255)
#  created_by_id                   :integer
#  supplier_id                     :integer
#  created_at                      :datetime
#  updated_at                      :datetime
#  remember_me_token               :string(255)
#  remember_me_token_expires_at    :datetime
#  reset_password_token            :string(255)
#  reset_password_token_expires_at :datetime
#  reset_password_email_sent_at    :datetime
#  number                          :integer
#  document_type                   :string(255)
#  document_number                 :string(255)
#  phone                           :string(255)
#  address                         :string(255)
#  username                        :string(255)
#  image_uid                       :string(255)
#  image_name                      :string(255)
#  card_number                     :string(255)
#  terms_accepted                  :boolean          default(FALSE)
#  card_printed                    :boolean          default(FALSE)
#  card_delivered                  :boolean          default(FALSE)
#  supplier_request_id             :integer
#  cache_points                    :integer          default(0)
#

class User < ActiveRecord::Base
  authenticates_with_sorcery!

  dragonfly_accessor :image

  ROLES = %w(god admin seller normal_user)
  DOCUMENT_TYPES = %w(dni cuil passport)

  # -- Scopes
  scope :search, ->(q) { where('card_number LIKE :q', q: "%#{q}%") }
  scope :with_role, ->(role) { where(role: role) }
  scope :all_from_supplier, ->(supplier) { where('supplier_id = ? AND role != ?', supplier.id, 'normal_user') }

  # -- Associations
  belongs_to :supplier
  belongs_to :supplier_request
  belongs_to :created_by, class_name: 'User'
  has_many :services, dependent: :destroy
  has_many :pfpc_services
  has_many :sales, foreign_key: :seller_id
  has_many :points_services

  # -- Validations
  validates :first_name, :last_name, :supplier, :document_type, :document_number, presence: true
  validates :password, confirmation: true
  validates :role, inclusion: {in: ROLES}
  validates :document_type, inclusion: {in: DOCUMENT_TYPES}
  validates :email, uniqueness: true
  validates :document_number, uniqueness: {scope: :document_type}

  def to_s
    "#{first_name} #{last_name}"
  end

  def is?(a_role)
    role == a_role.to_s
  end

  def to_param
    "#{id}-#{first_name}-#{last_name}".parameterize
  end

  def vademecums # TODO: and service is active
    services.where("type = 'PfpcService' AND status = 1").map &:vademecum
  end

  def accept_terms_of_use
    User.transaction do
      CardManager.accept_terms_of_use!(self)
      self.activate_pending_services
    end
  end

  def activate_pending_services
    pending_services.map { |serv| serv.update(status: 1) }
  end

  def pending_services
    services.select { |serv| serv.pending? }
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

end
