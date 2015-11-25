class SaleManager

  def initialize(query)
    @query = query
    @errors = []
  end

  {
    ticket: '12345',
    vendedor: 'some_seller',
    prestador: 'prestador1',
    fecha: '2016-05-05',
    sucursal: 'nombre_sucursal',
    total: 4000.0,
    numero_tarjeta: '1234-5678',
    productos: [
      {codigo: '5487-9856-1254-8546', cantidad: 100, costo: 50},
      {codigo: '9876-5487-9856-1254', cantidad:  80, costo: 40},
      {codigo: '4856-1254-6587-1689', cantidad:  70, costo: 30}
    ]
  }

  def update
    # TODO: Impactar ventas
    # SaleUpdater.new(...)
  end

  def authorize
    supplier = Supplier.find_by(name: @query[:prestador])
    seller   = supplier.users.where(role: 'seller').find_by(email: @query[:vendedor])
    client   = User.find_by(card_number: @query[:numero_tarjeta])
    products = @query[:productos]
    
    products.map do |product|
      price(product, supplier, client)
    end
  end

  def price(product, supplier, client)
    vademecum = client.vademecums.detect {|vademecum| vademecum.products.includes?(product)}
    if vademecum.present? && supplier.vademecums.includes?(vademecum)
      vademecum.discount(product)
    else
      0
    end
  end

  def valid_input?
    if @query.is_a?(Hash)
      return true
    else
      @errors << 'Consulta mal formada.'
    end
    false
  end

  def errors
    @errors
  end

end