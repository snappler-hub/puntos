class Discounter
  
  attr_accessor :discount
  
  def initialize(sale_product, afs)
    @product = sale_product.product
    @client = afs.client
    @supplier = afs.supplier
    @response = afs.response
    @discount = 0
    @health_insurance_id = sale_product.health_insurance_id
    @coinsurance_id = sale_product.coinsurance_id
  end
  
  # Porcentaje de descuento para un producto
  def call
    vademecums = @client.vademecums.select { |vademecum| vademecum.products.include?(@product) }
    if !vademecums.empty? && @client.has_supplier?(@supplier)
      @discount = get_discount(vademecums)
    else
      if vademecums.empty?
        warning = "#{@product.name.upcase}: no se encontró un vademecum, "
      else
        warning = 'El prestador no figura entre los servicios del cliente, '
      end
      @response.add_warning(warning+'por lo que no se aplicarán descuentos. ')
    end
    return self
  end
  
  def get_discount(vademecums)
    product_discounts = [] 
    for v in vademecums
      pd = ProductDiscount.find_by(vademecum: v, health_insurance_id: @health_insurance_id, coinsurance_id: @coinsurance_id, product: @product)
      product_discounts << pd unless pd.nil?
    end
    if product_discounts.empty? && (@health_insurance_id.present? || @coinsurance_id.present?)
      @response.add_warning("#{@product.name.upcase}: no hay datos asociados de la obra social o del coseguro. Para aplicar el descuento normal, no ingrese ninguna obra social ni coseguro para este producto.")
      return 0
    else
      return product_discounts.sort_by(&:discount).last.discount
    end
  end
  
  
end