# == Schema Information
#
# Table name: ALFABETA_Acciofar
#
#  codigo      :integer          not null, primary key
#  descripcion :string(50)       not null
#

module ManesPresent
  class PharmacologicAction < ActiveRecord::Base
    establish_connection :manes_present
    self.table_name = :ALFABETA_Acciofar

    def description
      Nokogiri::HTML.parse(descripcion).text.strip
    end
  end
end
