class SupplierRequest < ActiveRecord::Base
  
  # -- Scopes
  default_scope { order(created_at: :desc) }
  
  # -- Associations
  belongs_to :supplier
  belongs_to :created_by, class_name: 'User'
  
  # -- Validations
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :document_type, presence: true
  validates :document_number, presence: true  

  # -- Misc
  enum status: { requested: 0, rejected: 1, in_progress: 2, emitted: 3, pre_delivered: 4, delivered: 5 }
  DOCUMENT_TYPES = %w(dni cuil passport)
    
  # -- Methods
  
  # Returns client lastname and firstname
  def full_client_name
    "#{lastname}, #{firstname}"
  end  
  
  # Returns identification type and number
  def full_identification
    "#{document_type} #{document_number}"
  end
end
