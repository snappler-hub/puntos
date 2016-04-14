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

    vademecums.each { |v|
      pd = ProductDiscount.find_by(vademecum: v, product: @product)
      product_discounts << pd unless pd.nil? || product_discounts.include?(pd)
    }

    if product_discounts.empty?
      @response.add_warning("#{@product.name.upcase}: no se encontraron descuentos para el producto solicitado en ningún vademecum.")
      0
    else
      corresponding_discount(product_discounts)
    end
  end

  def corresponding_discount(product_discounts)
    collection = product_discounts.select { |pd| pd.health_insurance_id == @health_insurance_id && pd.coinsurance_id == @coinsurance_id }
    if collection.empty? || !health_insurance_and_coinsurance? #Chequear por OS o por COS
      hi_collection = product_discounts.select { |pd| pd.health_insurance_id == @health_insurance_id }
      co_collection = product_discounts.select { |pd| pd.coinsurance_id == @coinsurance_id }

      if (hi_collection.empty? && co_collection.empty?) || !health_insurance_and_coinsurance?
        discount = product_discounts.collect { |pd| pd.discount }.max # Descuento en efectivo
      else #Descuento Obra Social o Descuento Coseguro
        hi_discount = hi_collection.collect { |pd| pd.health_insurance_discount }.max
        co_discount = co_collection.collect { |pd| pd.coinsurance_discount }.max
        discount = [hi_discount, co_discount].compact.max
      end

    else #Descuento OS + COS
      discount = collection.collect { |pd| pd.health_insurance_and_coinsurance_discount }.max
    end

    discount
  end

  def health_insurance_and_coinsurance?
    @health_insurance_id.present? && @coinsurance_id.present?
  end
end

# 1) PRODUCTO CON OS y CO
#
# OS + CO correctos: OK, descuento OS+Cos.
#
# OS correcta, CO incorrecto: OK, descuento OS
#! OS correcta, CO null: NOK, descuento de contado
#! OS correcta, CO vacio: NOK, descuento de contado
#
# OS incorrecto, CO correcta: OK, descuento CO
#! OS null, CO correcta: NOK, descuento de contado, se espera descuento de CO
#! OS vacio, CO correcta: NOK,descuento de contado
#
# OS incorrecto, CO incorrecta: OK, descuento de contado
# OS incorrecto, CO null: OK, descuento de contado
# OS incorrecto, CO vacio: OK, descuento de contado
# OS null, CO incorrecta: OK, descuento de contado
# OS null, CO null: OK, descuento de contado
# OS null, CO vacio: OK, descuento de contado
# OS vacio, CO incorrecta: OK, descuento de contado
# OS vacio, CO null: OK, descuento de contado
# OS vacio, CO vacio: OK, descuento de contado


# 2) PRODUCTO CON OS y SIN CO
#
# OS correcta, CO incorrecto: OK, descuento de OS
#! OS correcta, CO null: NOK, descuento de contado, se espera descuento de OS
#! OS correcta, CO vacio: NOK, descuento de contado, se espera descuento de OS
#
# OS incorrecto, CO incorrecta: OK, descuento de contado
# OS incorrecto, CO null: OK, descuento de contado
# OS incorrecto, CO vacio: OK, descuento de contado
#
# OS null, CO incorrecta: OK, descuento de contado
# OS null, CO null: OK, descuento de contado
# OS null, CO vacio: OK, descuento de contado
#
# OS vacio, CO incorrecta: OK, descuento de contado
# OS vacio, CO null: OK, descuento de contado
# OS vacio, CO vacio: OK, descuento de contado


# 3) PRODUCTO SI OS y SIN CO
#
# OS incorrecto, CO incorrecta: OK, descuento de contado
# OS incorrecto, CO null: OK, descuento de contado
# OS incorrecto, CO vacio: OK, descuento de contado
#
# OS null, CO incorrecta: OK, descuento de contado
# OS null, CO null: OK, descuento de contado
# OS null, CO vacio: OK, descuento de contado
#
# OS vacio, CO incorrecta: OK, descuento de contado
# OS vacio, CO null: OK, descuento de contado
# OS vacio, CO vacio: OK, descuento de contado