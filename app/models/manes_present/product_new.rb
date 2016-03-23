# == Schema Information
#
# Table name: ALFABETA_Manual_DAT
#
#  troquel         :integer          not null
#  nombre          :string(44)       not null
#  presentacion    :string(24)       not null
#  IOMA01          :integer          not null
#  IOMA02          :string(1)        not null
#  IOMA03          :string(1)        not null
#  laboratorio     :string(16)       not null
#  precio          :integer          not null
#  fecha           :string(8)        not null
#  marca_pro_contr :string(1)        not null
#  importado       :string(1)        not null
#  tipo_venta      :string(1)        not null
#  IVA             :string(1)        not null
#  cod_desc_PAMI   :string(1)        not null
#  cod_lab         :integer          not null
#  nro_registro    :integer          not null, primary key
#  baja            :string(1)        not null
#  cod_barra       :string(13)       not null
#  unidades        :integer          not null
#  tamanio         :string(1)        not null
#  heladera        :string(1)        not null
#  SIFAR           :string(1)        not null
#  baja_esp        :string(1)        not null
#  blanco          :string(3)        not null
#  troquel_manes   :integer          not null
#

module ManesPresent
  class ProductNew < ActiveRecord::Base
    establish_connection :manes_present
    self.table_name = :productos_s

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
