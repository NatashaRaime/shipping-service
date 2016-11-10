require 'test_helper'

class ShipmentsControllerTest < ActionController::TestCase
  test "the truth" do
    assert true
  end
  test "can get index" do
    assert_response :success
  end
  test "can create a response" do
    shipment = {"origin" => {"country" => "US", "state" => "WA", "city" => "Seattle", "zip" => "98101"}, "destination" => {"country" => "US", "state" => "CA", "city" => "Los Angeles", "zip" => "92694"}, "packages" => {"weight" => "52", "dimensions" => ["11", "22", "33"], "units" => "imperial"}}
    post :create, {"shipment" => shipment}
    # binding.pry

    assert_response :created
  end

end
