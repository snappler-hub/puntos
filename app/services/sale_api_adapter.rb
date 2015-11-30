class SaleApiAdapter

  def initialize(query)
    @query = query
    @errors = []
  end

  def example
    {
      ticket: '12345',
      vendedor: 'DNI34841823',
      prestador: 'prestador1',
      fecha: '2016-05-05',
      sucursal: 'nombre_sucursal',
      total: 4000.0,
      numero_tarjeta: '1234-5678',
      productos: [
        {codigo: '5487561', cantidad: 100, costo: 50},
        {codigo: '987687945789', cantidad:  80, costo: 40},
        {codigo: '4856546', cantidad:  70, costo: 30}
      ]
    }
  end

  def sale
    Sale.new(client: client, sale_products: sale_products)
  end

  def client
    User.find_by(card_number: @query[:numero_tarjeta])
  end

  def seller
    User.find_by(email: @query[:vendedor])
  end

  def sale_products
    @query[:productos].map do |sale_product|
      codigo = sale_product(:codigo)

      product = if codigo.lenght == 13
        Product.find_by(bar_code: codigo)
      else
        Product.find_by(code: codigo)
      end

      SaleProduct.new(product: product, amount: sale_product[:cantidad], cost: sale_product[:cost])
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

    return true
  end

  def errors
    @errors
  end

  private

  def valid_products?
    @query[:products].all?{|product| Product.find_by(code: product[:codigo])}
  end

end