class User < ActiveRecord::Base
  authenticates_with_sorcery!

  dragonfly_accessor :image

  belongs_to :supplier
  belongs_to :created_by, class_name: 'User'
  has_many :cards

  validates :supplier, presence: true
  validates :password, confirmation: true

  ROLES = %w(god admin seller normal_user)
  DOCUMENT_TYPES = %w(dni cuil passport)

  def is?(a_role)
    role == a_role.to_s
  end

  def to_param
    "#{id}-#{first_name}-#{last_name}".parameterize
  end

end