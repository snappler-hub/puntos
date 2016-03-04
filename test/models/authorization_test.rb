# == Schema Information
#
# Table name: authorizations
#
#  id                  :integer          not null, primary key
#  seller_id           :integer
#  client_id           :integer
#  products            :text(65535)
#  status              :string(255)
#  message             :text(65535)
#  client_points       :float(24)        default(0.0)
#  seller_points       :float(24)        default(0.0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  health_insurance_id :integer
#  coinsurance_id      :integer
#

require 'test_helper'
require 'pp'

class AuthorizationTest < ActiveSupport::TestCase
  def setup    
    @user = users(:final_user)
    @seller = users(:seller)
    @vademecum = vademecums(:one)
    @supplier = @seller.supplier
  
    #Asociarle un pfpc al user
    @service = services(:pfpc)
    @service.run_callbacks(:create)
    @service.status = "in_progress"
    @service.vademecum = @vademecum
    # @service.product_pfpcs << product_pfpcs(:one)
    
    #Asociarle el vademecum al supplier del vendedor
    @supplier.vademecums << @vademecum
  
    @user.pfpc_services << @service
    
    #Para crear la autorizacion se requiere una venta (no persistida)
    sale_params = {client: @user, seller: @seller, "sale_products_attributes"=>{"1"=>{product: products(:one), amount: 12, cost: 20}}}
    @sale = Sale.new(sale_params)
    manager = AuthorizationFromSale.new(@sale, @sale.seller)
    @authorization = manager.authorize!
  end
  
  test "authorization status is ERROR if client hasn't accepted terms of use" do
    @sale.client.terms_accepted = false
    manager = AuthorizationFromSale.new(@sale, @sale.seller)
    authorization = manager.authorize!
    assert_includes authorization.message[Const::STATUS_ERROR], 'El cliente debe aceptar los términos de uso para poder operar en el sistema.'
  end
  
  test "should throw a warning if client do not have an active pfpc_service" do
    @sale.client = users(:final_user2)
    manager = AuthorizationFromSale.new(@sale, @sale.seller)
    authorization = manager.authorize!
    assert_equal 0, authorization.client.pfpc_services.count
    assert_includes authorization.message[Const::STATUS_WARNING], 'El cliente no posee ningún pfpc o período activo.'
  end
  
  test "shouldn't have status equal error if client have an active pfpc_service" do
    assert_equal Const::STATUS_OK, @authorization.status
  end
  
  test "should have one item in products" do
    # Se pide un producto con cantidad 12. De ese producto se aceptan 10 con descuento
    # y 2 sin descuento. Por eso quedan 2 productos
    assert_equal 2, @authorization.products.count
  end
  
  test "should have two items in products" do
    # TODO: No encuentra el prducto en el pfpc_service
    # pp @authorization.client.pfpc_services.detect { |pfpc| pfpc.products.include?(@product) }
  end
  
end
