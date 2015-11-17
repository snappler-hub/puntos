class SupplierRequest < ActiveRecord::Base

  # -- Scopes
  default_scope { order(created_at: :desc) }

  # -- Associations
  belongs_to :supplier
  belongs_to :created_by, class_name: 'User'
  has_many :comments, as: :commentable
  has_one :card

  # -- Validations
  validates :first_name, :last_name, :document_type, :document_number, :supplier, :created_by, presence: true

  # -- Misc
  enum status: {requested: 0, rejected: 1, in_progress: 2, emitted: 3, pre_delivered: 4, delivered: 5}

  # -- Methods

  # Returns client last_name and first_name
  def full_client_name
    "#{last_name}, #{first_name}"
  end

  # Returns identification type and number
  def full_identification
    "#{document_type} #{document_number}"
  end
  
  def can_be_viewed_by?(user)
    (user.is? :god) || (user.is?(:admin) && (user.supplier == self.supplier))
  end
end