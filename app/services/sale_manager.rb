class SaleManager

  def initialize(sale, seller)
    @sale     = sale
    @client   = sale.client
    @seller   = seller
    @supplier = seller.supplier
  end

  def authorize
    sale_products = @sale.sale_products
    
    sale_products.each do |sale_product|
      discount = discount(sale_product)
      sale_product.discount = discount
      sale_product.cost *= (1-discount)
    end

    @sale.sale_products = sale_products
    return @sale
  end

  def update
    # TODO: Impactar ventas
  end

  def discount(product)
    vademecum = @client.vademecums.detect {|vademecum| vademecum.products.includes?(product)}
    if vademecum.present? && @supplier.vademecums.includes?(vademecum)
      vademecum.discount(product)
    else
      0
    end
  end

end