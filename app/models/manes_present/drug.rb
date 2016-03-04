# == Schema Information
#
# Table name: ALFABETA_Monodro
#
#  codigo      :integer          not null, primary key
#  descripcion :string(32)       not null
#

module ManesPresent
  class Drug < ActiveRecord::Base
    establish_connection :manes_present
    self.table_name = :ALFABETA_Monodro

    def description
      replacement_rules = {
          '¢' => 'ó',
          '¡' => 'í'
      }
      matcher = /#{replacement_rules.keys.join('|')}/

      descripcion.strip.gsub(matcher) do |match|
        replacement_rules[match] || match
      end
    end
  end
end
