require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Sorcery::TestHelpers::Rails::Integration
  include Sorcery::TestHelpers::Rails::Controller

  setup do
    @supplier_user = users(:seller)
    @user = users(:admin)

    login_user(user = @user, route=login_url)
  end

  test "should get index" do
    get :index, supplier_id: @user.supplier_id
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new, supplier_id: @user.supplier_id
    assert_response :success
  end
  
  test "should create supplier user" do
    assert_difference('User.count') do
      post :create, supplier_id: @user.supplier_id, user: {
        first_name: @supplier_user.first_name, last_name: @supplier_user.last_name, document_type: @supplier_user.document_type,
        document_number: '12345678', phone: @supplier_user.phone, email: 'nuevo_email@prueba.com',
        address: @supplier_user.address, role: @supplier_user.role, password: '123123123', password_confirmation: '123123123'
      }
    end
    
    assert_equal(assigns(:user).created_by, @user)
    assert_equal(assigns(:user).supplier, @user.supplier)
    assert_redirected_to [@user.supplier, assigns(:user)]
  end

  test "should show supplier user" do
    get :show, id: @supplier_user, supplier_id: @user.supplier_id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @supplier_user, supplier_id: @user.supplier_id
    assert_response :success
  end

  test "should update supplier user" do
    patch :update, id: @supplier_user, supplier_id: @user.supplier_id, user: {
      first_name: @supplier_user.first_name, last_name: @supplier_user.last_name, document_type: @supplier_user.document_type,
      document_number: @supplier_user.document_number, phone: @supplier_user.phone, email: @supplier_user.email,
      address: @supplier_user.address
    }
    assert_redirected_to [@user.supplier, assigns(:user)]
  end

  test "should destroy supplier user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @supplier_user, supplier_id: @user.supplier_id
    end

    assert_redirected_to [@user.supplier, :users]
  end
end
