module ManesPresent
  class ProductExtra < ActiveRecord::Base
    establish_connection :manes_present
    self.table_name = :ALFABETA_Manextra

    def potency
      potencia.strip
    end

  end
end
