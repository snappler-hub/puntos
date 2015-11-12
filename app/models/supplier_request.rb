class SupplierRequest < ActiveRecord::Base
  
  # -- Scopes
  default_scope { order(created_at: :desc) }
  
  # -- Associations
  belongs_to :supplier
  belongs_to :created_by, class_name: 'User'
  
  # -- Validations
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :identification_type, presence: true
  validates :identification_number, presence: true  

  # -- Misc
  enum status: { requested: 0, rejected: 1, in_progress: 2, emitted: 3, pre_delivered: 4, delivered: 5 }
    
  # -- Methods
  
  # Returns client lastname and firstname
  def full_client_name
    "#{lastname}, #{firstname}"
  end  
  
  # Returns identification type and number
  def full_identification
    "#{identification_type} #{identification_number}"
  end
end
