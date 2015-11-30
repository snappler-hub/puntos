class SaleApiAdapterTest < ActiveSupport::TestCase

  VALID_QUERY = {
    ticket: users(:final_user).card_number,
    vendedor: users(:seller).email,
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
  
  test "input debe ser hash" do
    manager = SaleManager.new([])
    assert_equal false, manager.valid_input?
    assert_equal ['Consulta mal formada.'], manager.errors
  end

end