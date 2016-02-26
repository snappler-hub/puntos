class AuthorizationAdapter

  def initialize(query)
    @query = query
    @errors = []
  end

  def example_for_authorization #http://localhost:3000/api/sales/authorize
    {
      ticket: "12345",
      seller: "marcelo@manes.com.ar",
      supplier: "Drogueria Manes",
      health_insurance_id: 2,
      coinsurance_id: 1,
      date: "2016-02-26",
      subsidiary: "nombre_sucursal",
      card_number: "49D53710790824E6",
      products: [
          {code: "9901178", amount: 4, cost: 100},
          {code: "7794640408076", amount: 2, cost: 120}
      ]
    }
  end
  
  def example_for_sale #http://localhost:3000/api/sales/confirm
    {
    	authorization_id: "53"
    }
  end

  def sale
    Sale.new(client: client, health_insurance_id: @query[:health_insurance_id], coinsurance_id: @query[:coinsurance_id], sale_products: sale_products)
  end

  def client
    User.find_by(card_number: @query[:card_number])
  end

  def seller
    User.find_by(email: @query[:seller])
  end

  def sale_products
    @query[:products].map do |sale_product|
      code = sale_product[:code]
      product = if code.length == 13
                  Product.find_by(barcode: code)
                else
                  Product.find_by(troquel_number: code)
                end

      SaleProduct.new(product: product, amount: sale_product[:amount], cost: sale_product[:cost])
    end
  end

  def valid_input?
    unless @query.is_a?(Hash)
      @errors << 'Consulta mal formada.'
      return false
    end

    if client.blank?
      @errors << 'Cliente inválido'
      return false
    end

    if seller.blank?
      @errors << 'Vendedor inválido'
      return false
    end

    unless valid_products?
      @errors << 'Producto inválido'
      return false
    end

    true
  end

  def errors
    @errors
  end

  private

  def valid_products?
    @query[:products].all? { |product| Product.find_by(barcode: product[:code]) || Product.find_by(troquel_number: product[:code]) }
  end

end