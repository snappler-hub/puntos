class User < ActiveRecord::Base
  authenticates_with_sorcery!

  dragonfly_accessor :image

  ROLES = %w(god admin seller normal_user)
  DOCUMENT_TYPES = %w(dni cuil passport)

  belongs_to :supplier
  belongs_to :created_by, class_name: 'User'
  has_many :cards, dependent: :destroy

  validates :first_name, :last_name, :supplier, presence: true
  validates :password, confirmation: true
  validates :role, inclusion: {in: ROLES}
  validates :document_type, inclusion: {in: DOCUMENT_TYPES}
  validates :email, uniqueness: true

  def to_s
    "#{first_name} #{last_name}"
  end
  
  def card
    cards.last || false
  end

  #Este método lo uso para crear una tarjeta al crear un usuario.
  def card_number=(card_number)
    @card_number = card_number
  end

  def card_number
    @card_number || card && card.number
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
  
  # -------------------------------
  def can_view?(resource)
    resource.can_be_viewed_by?(self)
  end

end