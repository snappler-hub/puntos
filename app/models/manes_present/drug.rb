module ManesPresent
  class Drug < ActiveRecord::Base
    establish_connection :manes_present
    self.table_name = :monodrogas

    # def nombre
    #   replacement_rules = {
    #       '¢' => 'ó',
    #       '¡' => 'í'
    #   }
    #   matcher = /#{replacement_rules.keys.join('|')}/
    #
    #   nombre.strip.gsub(matcher) do |match|
    #     replacement_rules[match] || match
    #   end
    # end
  end
end
