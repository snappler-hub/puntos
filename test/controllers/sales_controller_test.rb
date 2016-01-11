require 'test_helper'

class SalesControllerTest < ActionController::TestCase
  include Sorcery::TestHelpers::Rails::Integration
  include Sorcery::TestHelpers::Rails::Controller
  
  setup do
    @user = users(:god)
    
    login_user(user = @user, route=login_url)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sales)
  end

  test "should get new" do
    get :new, supplier_id: @user.supplier_id, user_id: @user.id
    assert_response :success
  end

end
