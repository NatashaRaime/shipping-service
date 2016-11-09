require 'test_helper'

class ShipmentsControllerTest < ActionController::TestCase
  setup do
    @shipment = shipments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shipments)
  end

  test "should create shipment" do
    assert_difference('Shipment.count') do
      post :create, shipment: {  }
    end

    assert_response 201
  end

  test "should show shipment" do
    get :show, id: @shipment
    assert_response :success
  end

  test "should update shipment" do
    put :update, id: @shipment, shipment: {  }
    assert_response 204
  end

  test "should destroy shipment" do
    assert_difference('Shipment.count', -1) do
      delete :destroy, id: @shipment
    end

    assert_response 204
  end
end
