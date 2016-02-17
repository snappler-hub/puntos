class PfpcSupplier < ActiveRecord::Base
  # -- Associations
  belongs_to :supplier
  belongs_to :pfpc_service
  
  # -- Callbacks
  
  # -- Methods
end