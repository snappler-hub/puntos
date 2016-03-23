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

  def self.new_products
    ManesPresent::ProductNew.find_each do |each|
      Product.create(
          # code: each.nro_registro,
          # relative_presentation_size: each.cod_tam_rel_pres,
          # imported: each.importado,
          # sell_type: each.tipo_venta,
          # deleted: each.baja,

          troquel_number: each.troquel,
          barcode: each.cod_barras,
          name: each.name,
          price: each.prec_pub,

          presentation_form: each.presentation_form,
          expiration_date: each.fecha.to_date,

          units: each.unidades,
          size: each.tamanio,
          laboratory: Laboratory.where(name: each.laboratory).first_or_create,
          potency: each.potency,
          drug_id: each.cod_mono_v2
      ); nil
    end

    # `TROQUEL` int(11) NOT NULL DEFAULT '0'
    # `COD_BARRAS` varchar(17) NOT NULL DEFAULT ''
    # `PREC_PUB` double(16, 4) NOT NULL DEFAULT '0.0000'
    # `NOMBRE` varchar(38) NOT NULL DEFAULT ''


    # `NOMBRE_2` varchar(30) NOT NULL DEFAULT ''
    # `VARIEDAD` varchar(20) NOT NULL DEFAULT ''
    # `PRES_DOS` varchar(10) NOT NULL DEFAULT ''
    # `PRES_UNI` varchar(10) NOT NULL DEFAULT ''
    # `FORM1_NRO` double(16, 4) NOT NULL DEFAULT '0.0000'
    # `FORM1_UNI` varchar(18) NOT NULL DEFAULT ''
    # `VOLUM1_NRO` double(16, 4) NOT NULL DEFAULT '0.0000'
    # `VOLUM1_UNI` varchar(8) NOT NULL DEFAULT ''
    # `FORM2_NRO` double(16, 4) NOT NULL DEFAULT '0.0000'
    # `FORM2_UNI` varchar(18) NOT NULL DEFAULT ''
    # `VOLUM2_NRO` double(16, 4) NOT NULL DEFAULT '0.0000'
    # `VOLUM2_UNI` varchar(8) NOT NULL DEFAULT ''
    # `COD_LABO` int(11) NOT NULL DEFAULT '0'
    # `PATOLOGIA` int(11) NOT NULL DEFAULT '0'
    # `cod_mono_v2` bigint(20) NOT NULL DEFAULT '0'
    # `cod_alfabeta` bigint(20) NOT NULL

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
