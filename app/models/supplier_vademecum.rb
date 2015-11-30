class SupplierVademecum < ActiveRecord::Base
  belongs_to :supplier
  belongs_to :vademecum
end
