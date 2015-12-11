class SupplierPointProduct < ActiveRecord::Base
  
  # Associations
  belongs_to :supplier
  belongs_to :product
  
  # Validates 
  validates :supplier, presence: true 
  validates :product, presence: true 
  
end
