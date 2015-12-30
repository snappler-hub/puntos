module ManesPresent
  class Product < ActiveRecord::Base
    establish_connection :manes_present
    self.table_name = :ALFABETA_Manual_DAT
  end
end
