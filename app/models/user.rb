class User < ActiveRecord::Base
  authenticates_with_sorcery!

  dragonfly_accessor :image

  ROLES = %w(god admin seller normal_user)
  DOCUMENT_TYPES = %w(dni cuil passport)

  belongs_to :supplier
  belongs_to :created_by, class_name: 'User'
  has_many :cards

  validates :supplier, presence: true
  validates :password, confirmation: true
  validates :role, inclusion: {in: ROLES}
  validates :document_type, inclusion: {in: DOCUMENT_TYPES}

  def card
    cards.last || false
  end

  def accept_terms_of_use!
    card ? card.update(terms_accepted: true) : false
  end

  def is?(a_role)
    role == a_role.to_s
  end

  def to_param
    "#{id}-#{first_name}-#{last_name}".parameterize
  end

end