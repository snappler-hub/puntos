require 'test_helper'

class AuthorizationsControllerTest < ActionController::TestCase
  include Sorcery::TestHelpers::Rails::Integration
  include Sorcery::TestHelpers::Rails::Controller
  
  setup do
    @user = users(:god)
    
    login_user(user = @user, route=login_url)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:authorizations)
  end

  test "should create authorization" do
    products = [{product_id: products(:one).id, amount: 8, cost: 100}, {product_id: products(:two).id, amount: 1, cost: 80}]
    assert_difference('Authorization.count', 1) do
      post :create, format: :js, sale: { seller_id: users(:seller).id, client_id: users(:final_user).id, 
             sale_products_attributes: products }
    end
  end
end
