class Discounter
  
  attr_accessor :discount
  
  def initialize(product, afs)
    @product = product
    @client = afs.client
    @supplier = afs.supplier
    @response = afs.response
    @discount = 0
  end
  
  # Porcentaje de descuento para un producto
  def call
    vademecum = @client.vademecums.detect { |vademecum| vademecum.products.include?(@product) }
    if vademecum.present? && @client.has_supplier?(@supplier)
      @discount = vademecum.product_discounts.detect { |discount| discount.product == @product }.discount
    else
      if vademecum.blank?
        warning = "No se encontró un vademecum con el producto #{@product.name}, "
      else
        warning = 'El prestador no figura entre los servicios del cliente, '
      end
      @response.add_warning(warning+'por lo que no se aplicarán descuentos. ')
    end
    return self
  end
  
  
end