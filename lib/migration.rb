class Migration

  def self.all
    self.acciofar
    self.monodroga
    self.products
    self.products_extra
  end

  def self.acciofar
    ManesPresent::PharmacologicAction.find_each do |each|
      PharmacologicAction.create(
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
          code: each.nro_registro,
          name: each.name,
          presentation_form: each.presentation_form,
          price: each.precio,
          expiration_date: each.fecha.to_date,
          imported: each.importado,
          sell_type: each.tipo_venta,
          deleted: each.baja,
          units: each.unidades,
          size: each.tamanio,
          troquel_number: each.troquel,
          barcode: each.cod_barra,
          laboratory: Laboratory.where(name: each.laboratory).first_or_create
      ); nil
    end
  end


  def self.products_extra
    ManesPresent::ProductExtra.find_each do |each|
      p = Product.where(id: each.num_reg).first
      unless p.nil?
        p.potency = each.potency
        p.relative_presentation_size = each.cod_tam_rel_pres
        p.drug_id = each.cod_droga
        # No se migraron
        # p.pharmacologic_action_id = each.cod_acc_farma
        # p.pharmacologic_form_id = each.cod_forma_farma
        # p.potency_unit_id = each.cod_uni_potencia
        # p.unit_type_id = each.cod_tipo_uni
        # p.administration_route_id = each.cod_via_admini
        p.save
      end
    end
  end

  # Quedaron por fuera
  # IOMA01
  # IOMA02
  # IOMA03
  # IVA
  # cod_desc_PAMI
  # cod_lab
  # heladera
  # baja_esp
  # blanco
  # troquel_manes
  # marca_pro_contr

end
