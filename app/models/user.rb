class User < ActiveRecord::Base
  authenticates_with_sorcery!

  dragonfly_accessor :image

  ROLES = %w(god admin seller normal_user)
  DOCUMENT_TYPES = %w(dni cuil passport)

  belongs_to :supplier
  belongs_to :supplier_request
  belongs_to :created_by, class_name: 'User'

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
  
  # -------------------------------
  def can_view?(resource)
    resource.can_be_viewed_by?(self)
  end

end