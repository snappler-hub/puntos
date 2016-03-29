class Migration

  def self.cleanup
    Sale.destroy_all
    Authorization.destroy_all
    Comment.destroy_all
    PeriodProduct.destroy_all
    PfpcPeriod.destroy_all
    PfpcSupplier.destroy_all
    PointsPeriod.destroy_all
    ProductDiscount.destroy_all
    ProductPfpc.destroy_all
    RewardOrderItem.destroy_all
    RewardOrder.destroy_all
    Reward.destroy_all
    SaleProduct.destroy_all
    SupplierPointProduct.destroy_all
    Service.destroy_all
    Vademecum.destroy_all
  end


  # def self.drugs
  #   Drug.destroy_all
  #   ManesPresent::Drug.find_each do |each|
  #     Drug.create(
  #         id: each.codigo,
  #         name: each.nombre
  #     ); nil
  #   end
  # end


  # def self.laboratories
  #   Laboratory.destroy_all
  #   ManesPresent::Laboratory.all.each do |each|
  #     Laboratory.create(
  #         id: each.codigo,
  #         name: each.nombre
  #     ); nil
  #   end
  #   Laboratory.create(
  #       name: 'Sin identificar'
  #   ); nil
  # end


  def self.alfabeta

    Product.destroy_all
    Drug.destroy_all
    Laboratory.destroy_all


    filename = Rails.root.join('lib', 'data', 'monodro.txt')

    File.open(filename, 'r:CP850:utf-8') do |file|
      file.each_line do |line|
        Drug.create(
            id: line[0, 5],
            name: "#{line[5, 32].squeeze(' ').strip}",
        )
      end
    end


    filename = Rails.root.join('lib', 'data', 'manual.dat')

    File.open(filename, 'r:CP850:utf-8') do |file|
      file.each_line do |line|
        Product.create(
            troquel_number: line[0, 7],
            name: "#{line[7, 44].squeeze(' ').strip}",
            presentation_form: "#{line[51, 24].squeeze(' ').strip}",
            full_name: "#{line[7, 44].squeeze(' ').strip}, #{line[51, 24].squeeze(' ').strip}",
            laboratory: Laboratory.where(name: "#{line[85, 16].squeeze(' ').strip}").first_or_create,
            price_in_cents: line[101, 9],
            alfabeta_identifier: line[126, 5],
            barcode: line[132, 13]
        )
      end
    end


    filename = Rails.root.join('lib', 'data', 'manextra.txt')

    File.open(filename, 'r:CP850:utf-8') do |file|
      file.each_line do |line|
        p = Product.where(alfabeta_identifier: line[0, 5]).take
        unless p.nil?
          p.update_column(:drug_id, line[12, 5])
          p.save
        end
      end
    end

    ### Campos de Product no usados
    # administration_route_id
    # code
    # deleted
    # expiration_date
    # imported
    # potency
    # presentation_form
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
