module ManesPresent
  class PharmacologicalScope < ActiveRecord::Base
    establish_connection :manes_present
    self.table_name = :ALFABETA_acciofar
  end
end