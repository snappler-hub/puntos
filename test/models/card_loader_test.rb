class CardLoaderTest < ActiveSupport::TestCase

  VALID_QUERY = [
    {number: '12345'},
    {number: '45687'}
  ]
  
  test "input debe ser array" do
    card_loader = CardLoader.new({})
    assert_equal false, card_loader.valid_input?
    assert_equal ['Debe ser un arreglo: [{number: "123456"}]'], card_loader.errors
  end

  test "debe tener tarjetas correctas" do
    card_loader = CardLoader.new([{foo: 'bar'}])
    assert_equal false, card_loader.valid_input?
    assert_equal ['Las tarjetas deben tener formato válido.'], card_loader.errors
  end

end