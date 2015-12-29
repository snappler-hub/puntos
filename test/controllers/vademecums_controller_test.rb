require 'test_helper'

class VademecumsControllerTest < ActionController::TestCase
  include Sorcery::TestHelpers::Rails::Integration
  include Sorcery::TestHelpers::Rails::Controller
  
  setup do
    @vademecum = vademecums(:one)
    @independent = vademecums(:independent)
    @product1 = products(:one)
    @product2 = products(:two)
    
    @user = users(:god)
    
    login_user(user = @user, route=login_url)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vademecums)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vademecum" do
    # TODO Products discount association
    assert_difference('Vademecum.count') do
      post :create, vademecum: { name: @vademecum.name }
    end

    assert_redirected_to vademecums_path
  end

  test "should get edit" do
    get :edit, id: @vademecum
    assert_response :success
  end

  test "should update vademecum" do
    # TODO Products discount association
    patch :update, id: @vademecum, vademecum: { name: @vademecum.name }
    assert_redirected_to vademecums_path
  end

  test "should destroy vademecum" do
    assert_difference('Vademecum.count', -1) do
      delete :destroy, id: @independent
    end

    assert_redirected_to vademecums_path
  end
  
  test "should not destroy vademecum if it has products" do
    assert_difference('Vademecum.count', 0) do
      delete :destroy, id: @vademecum
    end

    assert_redirected_to vademecums_path
  end
end
