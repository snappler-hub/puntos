class HealthInsurance < ActiveRecord::Base

  # -- Scopes
  scope :search, ->(q) { where('name LIKE :q', q: "%#{q}%") }
  
  # -- Associations

  # -- Validations
  validates :name, presence: true
  
  # -- Methods


end