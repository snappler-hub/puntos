class Migration

  def self.acciofar
    ManesPresent::PharmacologicalAction.find_each do |each|
      PharmacologicalAction.create(
          id: each.id,
          name: each.description
      ); nil
    end
  end

  def self.monodroga
    ManesPresent::Drug.find_each do |each|
      Drug.create(
          id: each.id,
          name: each.description
      ); nil
    end
  end

  def self.products
    ManesPresent::Product.find_each do |each|
      Product.create(
          id: each.nro_registro,
          name: each.nombre,
          presentation_form: each.presentation_form,
          price: each.precio,
          expiration_date: each.fecha.to_date,
          imported: each.importado,
          sell_type: each.tipo_venta,
          # deleted: each.baja,
          # units: each.unidades,
          # size: each.tamanio,
          # sifar: each.SIFAR,
          # troquel_number: each.troquel,
          laboratory: EntityGroup.where(name: each.laboratory).first_or_create
      ); nil

      # ManesPresent::Extra
      # Product.find(id: num_reg)
      # potency: potencia
      # relative_presentation_size_id (class_name: PresentationSize): cod_tam_rel_pres
      # pharmacological_action_id: cod_acc_farma
      # drug_id: cod_droga
      # pharmacologic_form_id: cod_forma_farma
      # potency_unit_id: cod_uni_potencia
      # unit_type_id: cod_tipo_uni
      # administration_route_id: cod_via_admini

      # IOMA01
      # IOMA02
      # IOMA03
      # IVA
      # cod_desc_PAMI
      # cod_lab
      # cod_barra
      # heladera
      # baja_esp
      # blanco
      # troquel_manes
      # marca_pro_contr

    end
  end

end
