module ManesPresent
  class Laboratory < ActiveRecord::Base
    establish_connection :manes_present
    self.table_name = :laboratorios

    default_scope -> { order('codigo ASC') }

    def codigo
      self.CODIGO
    end

    def nombre
      self.NOMBRE
    end
  end
end
