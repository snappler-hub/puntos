# == Schema Information
#
# Table name: pfpc_suppliers
#
#  id              :integer          not null, primary key
#  pfpc_service_id :integer
#  supplier_id     :integer
#

class PfpcSupplier < ActiveRecord::Base
  # -- Associations
  belongs_to :supplier
  belongs_to :pfpc_service
  
  # -- Callbacks
  
  # -- Methods
end
