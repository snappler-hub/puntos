module ManesPresent
  class Product < ActiveRecord::Base
    establish_connection :manes_present
    self.table_name = :ALFABETA_Manual_DAT

    def sanitize_string(str)
      replacement_rules = {
          '¢' => 'ó',
          '¡' => 'í'
      }
      matcher = /#{replacement_rules.keys.join('|')}/

      str.strip.gsub(matcher) do |match|
        replacement_rules[match] || match
      end
    end

    def name
      sanitize_string nombre
    end

    def laboratory
      sanitize_string laboratorio
    end

    def presentation_form
      sanitize_string presentacion
    end

  end
end
