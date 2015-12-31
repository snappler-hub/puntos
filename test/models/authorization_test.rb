# == Schema Information
#
# Table name: authorizations
#
#  id         :integer          not null, primary key
#  seller_id  :integer
#  client_id  :integer
#  products   :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :string(255)
#  message    :text(65535)
#  points     :integer          default(0)
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
    error_authorization = manager.authorize!
    assert_equal Const::STATUS_ERROR, error_authorization.status
  end
  
  test "should throw a warning if client do not have an active pfpc_service" do
    @user.pfpc_services = []
    assert_equal 0, @authorization.client.pfpc_services.count
    assert_equal Const::STATUS_WARNING, @authorization.status
  end
  
  test "shouldn't have status equal error if client have an active pfpc_service" do
    refute_equal Const::STATUS_ERROR, @authorization.status
  end
  
  test "should have one item in products" do
    assert_equal 1, @authorization.products.count
  end
  
  test "should have two items in products" do
    #TODO No encuentra el prducto en el pfpc_service
    pp @authorization.client.pfpc_services.detect { |pfpc| pfpc.products.include?(@product) }
  end
  
end
