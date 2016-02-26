class Discounter

  attr_accessor :discount

  def initialize(sale_product, afs)
    @product = sale_product.product
    @client = afs.client
    @supplier = afs.supplier
    @response = afs.response
    @discount = 0
    @health_insurance_id = afs.health_insurance_id
    @coinsurance_id = afs.coinsurance_id
  end

  # Porcentaje de descuento para un producto
  def call
    vademecums = @client.vademecums.select { |vademecum| vademecum.products.include?(@product) }
    if vademecums.any? && @client.has_supplier?(@supplier)
      @discount = get_discount(vademecums)
    else
      if vademecums.empty?
        warning = "#{@product.name.upcase}: no se encontró un vademecum, "
      else
        warning = 'El prestador no figura entre los servicios del cliente, '
      end
      @response.add_warning(warning+'por lo que no se aplicarán descuentos. ')
    end
    self
  end

  def get_discount(vademecums)
    product_discounts = []

    for v in vademecums
      pd = ProductDiscount.find_by(vademecum: v, product: @product)
      product_discounts << pd unless pd.nil?
    end

    if product_discounts.empty?
      @response.add_warning("#{@product.name.upcase}: no se encontraron descuentos para el producto solicitado en ningún vademecum.")
      0
    else
      corresponding_discount(product_discounts)
    end
  end

  def corresponding_discount(product_discounts)
    if @health_insurance_id.nil? && @coinsurance_id.nil?
      product_discounts.sort_by { |pd1| pd1.discount }.last.discount
    elsif @health_insurance_id.nil?
      product_discounts.sort_by { |pd1| pd1.coinsurance_discount }.last.coinsurance_discount
    elsif @coinsurance_id.nil?
      product_discounts.sort_by { |pd1| pd1.health_insurance_discount }.last.health_insurance_discount
    else
      product_discounts.sort_by { |pd1| pd1.health_insurance_and_coinsurance_discount }.last.health_insurance_and_coinsurance_discount
    end
  end

end