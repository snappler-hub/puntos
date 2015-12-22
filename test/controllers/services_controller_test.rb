require 'test_helper'

class ServicesControllerTest < ActionController::TestCase
  include Sorcery::TestHelpers::Rails::Integration
  include Sorcery::TestHelpers::Rails::Controller

  setup do
    @points_service = services(:points)
    @pfpc_service = services(:pfpc)
    @final_user = users(:final_user)
    
    @user = users(:god)

    login_user(user = @user, route=login_url)
  end

  test "should get new points service" do
    get :new, user_id: @final_user.id, type: 'points'
    assert_response :success
    assert_not_nil assigns(:service)
  end
  
  test "should create points service" do
    assert_difference('PointsService.count') do
      post :create, user_id: @final_user.id, service: {
        name: @points_service.name, type: @points_service.type, amount: @points_service.amount
      }
    end
    
    assert_equal(assigns(:service).user, @final_user)
    assert_redirected_to [@final_user, assigns(:service)]
  end
  
  test "should create pfpc service" do
    vademecum = vademecums(:one)
    assert_difference('PfpcService.count') do
      post :create, user_id: @final_user.id, service: {
        vademecum_id: vademecum.id, days: 30,
        name: @pfpc_service.name, type: @pfpc_service.type
      }
    end
    
    assert_equal(assigns(:service).user, @final_user)
    assert_redirected_to [@final_user, assigns(:service)]
  end
  
  test "should get edit" do
    get :edit, id: @pfpc_service, user_id: @final_user.id
    assert_response :success
    
    get :edit, id: @points_service, user_id: @final_user.id
    assert_response :success
  end
  
  test "should destroy points service" do
    assert_difference('PointsService.count', -1) do
      delete :destroy, id: @points_service, user_id: @final_user.id
    end

    assert_redirected_to @final_user
  end
  
  test "should destroy PFPC service" do
    assert_difference('PfpcService.count', -1) do
      delete :destroy, id: @pfpc_service, user_id: @final_user
    end

    assert_redirected_to @final_user
  end

  
end
