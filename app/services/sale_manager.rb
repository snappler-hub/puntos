class SaleManager

  def initialize(sale, seller)
    @client   = sale.client
    @sale_products = sale.sale_products
    @seller   = seller
    @supplier = seller.supplier
  end

  def authorize
    Authorization.new(
      client: @client,
      seller: @seller,
      products: products
    )
  end

  def authorize!
    authorization = authorize
    authorization.save!
    return authorization
  end

  def products
    @sale_products.map do |sale_product|
      total = sale_product.amount * sale_product.cost
      discount = discount(sale_product)

      {
        id: sale_product.product_id,
        amount: sale_product.amount,
        cost: sale_product.cost,
        discount: discount,
        total: (total * (1-discount))
      }
    end
  end

  def discount(product)
    # TODO: no debería funcionar así.
    # Habría que ver cuantos te acepta con ese descuento, y el resto ponerlos sin descuento.
    vademecum = @client.vademecums.detect {|vademecum| vademecum.products.includes?(product)}
    if vademecum.present? && @supplier.vademecums.includes?(vademecum)
      vademecum.discount(product) * 0.01
    else
      0
    end
  end

end