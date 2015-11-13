require 'test_helper'

class SupplierRequestsControllerTest < ActionController::TestCase
  setup do
    @supplier_request = supplier_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:supplier_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end
end
