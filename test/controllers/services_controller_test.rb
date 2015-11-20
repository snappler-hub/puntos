require 'test_helper'

class ServicesControllerTest < ActionController::TestCase
  include Sorcery::TestHelpers::Rails::Integration
  include Sorcery::TestHelpers::Rails::Controller

  setup do
    @points_service = services(:points)
    @pfpc_service = services(:pfpc)
    @card = cards(:one)
    
    @user = users(:god)

    login_user(user = @user, route=login_url)
  end

  test "should get new points service" do
    get :new, card_id: @card.id, type: 'points'
    assert_response :success
    assert_not_nil assigns(:service)
  end
  
  test "should create points service" do
    assert_difference('ServicePoints.count') do
      post :create, card_id: @card.id, service: {
        name: @points_service.name, type: @points_service.type, amount: @points_service.amount
      }
    end
    
    assert_equal(assigns(:service).card, @card)
    assert_redirected_to [@card, assigns(:service)]
  end
  
  test "should create pfpc service" do
    assert_difference('ServicePfpc.count') do
      post :create, card_id: @card.id, service: {
        name: @pfpc_service.name, type: @pfpc_service.type
      }
    end
    
    assert_equal(assigns(:service).card, @card)
    assert_redirected_to [@card, assigns(:service)]
  end
  
  test "should get edit" do
    get :edit, id: @pfpc_service, card_id: @card.id
    assert_response :success
    
    get :edit, id: @points_service, card_id: @card.id
    assert_response :success
  end
  
  test "should destroy points service" do
    assert_difference('ServicePoints.count', -1) do
      delete :destroy, id: @points_service, card_id: @card.id
    end

    assert_redirected_to @card.user
  end
  
  test "should destroy PFPC service" do
    assert_difference('ServicePfpc.count', -1) do
      delete :destroy, id: @pfpc_service, card_id: @card.id
    end

    assert_redirected_to @card.user
  end

  
end
