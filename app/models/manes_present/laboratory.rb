module ManesPresent
  class Laboratory < ActiveRecord::Base
    establish_connection :manes_present
    self.table_name = :laboratorios
  end
end
