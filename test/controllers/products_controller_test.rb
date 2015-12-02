require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  include Sorcery::TestHelpers::Rails::Integration
  include Sorcery::TestHelpers::Rails::Controller
  
  setup do
    @product = products(:one)
    @user = users(:god)
    
    login_user(user = @user, route=login_url)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: { code: '1111', name: 'Producto cualquiera', points: @product.points }
    end

    assert_redirected_to products_path
  end

  test "should get edit" do
    get :edit, id: @product
    assert_response :success
  end

  test "should update product" do
    patch :update, id: @product, product: { code: @product.code, name: @product.name, points: @product.points }
    assert_redirected_to products_path
  end

  test "should destroy product" do
    prod = products(:independent)
    assert_difference('Product.count', -1) do
      delete :destroy, id: prod
    end

    assert_redirected_to products_path
  end
end
