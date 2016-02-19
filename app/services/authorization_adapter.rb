class AuthorizationAdapter

  def initialize(query)
    @query = query
    @errors = []
  end

  def example
    {
        ticket: '12345',
        seller: 'DNI34841823',
        supplier: 'prestador1',
        date: '2016-05-05',
        subsidiary: 'nombre_sucursal',
        total: 4000.0,
        card_number: '1234-5678',
        products: [
            {code: '5487561', amount: 100, cost: 50, health_insurance_id: 1, coinsurance: 1},
            {code: '987687945789', amount: 80, cost: 40, health_insurance_id: 2},
            {code: '4856546', amount: 70, cost: 30}
        ]
    }
  end

  def sale
    Sale.new(client: client, sale_products: sale_products)
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
                  Product.find_by(bar_code: code)
                else
                  Product.find_by(code: code)
                end

      SaleProduct.new(product: product, amount: sale_product[:amount], cost: sale_product[:cost], health_insurance_id: sale_product[:health_insurance_id], coinsurance_id: sale_product[:coinsurance_id])
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
    @query[:products].all? { |product| Product.find_by(code: product[:code]) }
  end

end