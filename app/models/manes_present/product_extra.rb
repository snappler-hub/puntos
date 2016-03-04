# == Schema Information
#
# Table name: ALFABETA_Manextra
#
#  num_reg          :integer          not null, primary key
#  cod_tam_rel_pres :integer          not null
#  cod_acc_farma    :integer          not null
#  cod_droga        :integer          not null
#  cod_forma_farma  :integer          not null
#  potencia         :string(16)       not null
#  cod_uni_potencia :integer          not null
#  cod_tipo_uni     :integer          not null
#  cod_via_admini   :integer          not null
#

module ManesPresent
  class ProductExtra < ActiveRecord::Base
    establish_connection :manes_present
    self.table_name = :ALFABETA_Manextra

    def potency
      potencia.strip
    end

  end
end
