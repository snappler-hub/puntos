class Migration

  def self.all
    self.cleanup
    # self.acciofar
    self.drugs
    self.laboratories
    self.products
    # self.products_extra
  end


  #
  # TODO borrar el modelo?
  #
  # def self.acciofar
  #   ManesPresent::PharmacologicAction.find_each do |each|
  #     PharmacologicAction.create(
  #         id: each.id,
  #         name: each.description
  #     ); nil
  #   end
  # end

  def self.cleanup
    Sale.destroy_all
    Authorization.destroy_all
    Comment.destroy_all
    PeriodProduct.destroy_all
    PfpcPeriod.destroy_all
    PfpcSupplier.destroy_all
    PharmacologicAction.destroy_all
    PointsPeriod.destroy_all
    ProductDiscount.destroy_all
    ProductPfpc.destroy_all
    RewardOrderItem.destroy_all
    RewardOrder.destroy_all
    Reward.destroy_all
    SaleProduct.destroy_all
    Service.destroy_all
    Vademecum.destroy_all
  end



  def self.drugs
    # Drug.destroy_all
    ActiveRecord::Base.connection.execute('TRUNCATE drugs RESTART IDENTITY')
    ManesPresent::Drug.find_each do |each|
      Drug.create(
          id: each.codigo,
          name: each.nombre
      ); nil
    end
  end


  def self.laboratories
    # Laboratory.destroy_all
    ActiveRecord::Base.connection.execute('TRUNCATE laboratories RESTART IDENTITY')
    ManesPresent::Laboratory.find_each do |each|
      Laboratory.create(
          id: each.codigo,
          name: each.nombre
      ); nil
    end
  end


  def self.products
    # Product.destroy_all
    ActiveRecord::Base.connection.execute('TRUNCATE products RESTART IDENTITY')
    ManesPresent::Product.find_each do |each|
      Product.create(
          name: each.nombre_largo.squeeze(' ').strip,
          price: each.prec_pub,
          troquel_number: each.troquel,
          barcode: each.cod_barra,
          drug_id: each.cod_mono_v2,
          laboratory_id: each.cod_labo
      ); nil
    end

    ### Campos de Product no usados
    # administration_route_id
    # code
    # deleted
    # expiration_date
    # imported
    # potency
    # presentation_form
    # pharmacologic_action_id
    # pharmacologic_form_id
    # potency_unit_id
    # relative_presentation_size
    # registration_number
    # sell_type
    # size
    # unit_type_id
    # units

    ### Tabla manes
    #
    # Campos usados:
    # TROQUEL
    # COD_LABO
    # PREC_PUB
    # COD_BARRAS
    # NOMBRE_LARGO
    # cod_mono_v2
    #
    # Campos no usados:
    # cod_alfabeta
    # PATOLOGIA
    # XBLOQUEO
    #

  end


  # def self.products
  #   ManesPresent::Product.find_each do |each|
  #     Product.create(
  #         id: each.nro_registro,
  #         code: each.nro_registro,
  #         name: each.name,
  #         presentation_form: each.presentation_form,
  #         price: each.precio,
  #         expiration_date: each.fecha.to_date,
  #         imported: each.importado,
  #         sell_type: each.tipo_venta,
  #         deleted: each.baja,
  #         units: each.unidades,
  #         size: each.tamanio,
  #         troquel_number: each.troquel,
  #         barcode: each.cod_barra,
  #         laboratory: Laboratory.where(name: each.laboratory).first_or_create
  #     ); nil
  #   end
  # end


  # def self.products_extra
  #   ManesPresent::ProductExtra.find_each do |each|
  #     p = Product.where(id: each.num_reg).first
  #     unless p.nil?
  #       p.potency = each.potency
  #       p.relative_presentation_size = each.cod_tam_rel_pres
  #       p.drug_id = each.cod_droga
  #       # No se migraron
  #       # p.pharmacologic_action_id = each.cod_acc_farma
  #       # p.pharmacologic_form_id = each.cod_forma_farma
  #       # p.potency_unit_id = each.cod_uni_potencia
  #       # p.unit_type_id = each.cod_tipo_uni
  #       # p.administration_route_id = each.cod_via_admini
  #       p.save
  #     end
  #   end
  # end


  # def self.new_products
  #   ManesPresent::ProductNew.find_each do |each|
  #     Product.create(
  #         # code: each.nro_registro,
  #         # relative_presentation_size: each.cod_tam_rel_pres,
  #         # imported: each.importado,
  #         # sell_type: each.tipo_venta,
  #         # deleted: each.baja,
  #         # expiration_date: each.fecha.to_date,
  #         # units: each.unidades,
  #         # size: each.tamanio,
  #         # potency: each.potency,
  #
  #         troquel_number: each.troquel,
  #         barcode: each.cod_barras,
  #         name: each.name,
  #         price: each.prec_pub,
  #         laboratory_id: each.cod_labo,
  #         drug_id: each.cod_mono_v2
  #         # presentation_form: each.presentation_form,
  #     ); nil
  #   end
  # end

end
