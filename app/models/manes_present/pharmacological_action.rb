module ManesPresent
  class PharmacologicalAction < ActiveRecord::Base
    establish_connection :manes_present
    self.table_name = :ALFABETA_Acciofar

    def description
      Nokogiri::HTML.parse(descripcion).text.strip
    end
  end
end
