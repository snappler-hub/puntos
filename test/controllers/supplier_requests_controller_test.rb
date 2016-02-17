require 'test_helper'

class SupplierRequestsControllerTest < ActionController::TestCase
  include Sorcery::TestHelpers::Rails::Integration
  include Sorcery::TestHelpers::Rails::Controller

  setup do
    @supplier_request = supplier_requests(:one)
    @user = users(:admin)

    login_user(user = @user, route=login_url)
  end

  test "should get index" do
    get :index, supplier_id: @user.supplier_id
    assert_response :success
    assert_not_nil assigns(:supplier_requests)
  end

  test "should get new" do
    get :new, supplier_id: @user.supplier_id
    assert_response :success
  end

  test "should create supplier request" do
    assert_difference('SupplierRequest.count') do
      post :create, supplier_id: @user.supplier_id, supplier_request: {
        first_name: @supplier_request.first_name, last_name: @supplier_request.last_name, document_type: @supplier_request.document_type,
        document_number: @supplier_request.document_number, phone: @supplier_request.phone, email: @supplier_request.email,
        address: @supplier_request.address, notes: @supplier_request.notes
      }
    end

    assert_equal(assigns(:supplier_request).created_by, @user)
    assert_equal(assigns(:supplier_request).supplier, @user.supplier)
    assert_redirected_to [@user.supplier, assigns(:supplier_request)]
  end

  test "should show supplier request" do
    get :show, id: @supplier_request, supplier_id: @user.supplier_id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @supplier_request, supplier_id: @user.supplier_id
    assert_response :success
  end

  test "should update supplier request" do
    patch :update, id: @supplier_request, supplier_id: @user.supplier_id, supplier_request: {
      first_name: @supplier_request.first_name, last_name: @supplier_request.last_name, document_type: @supplier_request.document_type,
      document_number: @supplier_request.document_number, phone: @supplier_request.phone, email: @supplier_request.email,
      address: @supplier_request.address, notes: @supplier_request.notes
    }
    assert_redirected_to [@user.supplier, assigns(:supplier_request)]
  end

end
