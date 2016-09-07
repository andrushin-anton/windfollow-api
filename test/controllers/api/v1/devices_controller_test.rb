require 'test_helper'

class Api::V1::DevicesControllerTest < ActionController::TestCase
  setup do
    @api_v1_device = api_v1_devices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_v1_devices)
  end

  test "should create api_v1_device" do
    assert_difference('Api::V1::Device.count') do
      post :create, api_v1_device: { name: @api_v1_device.name, token: @api_v1_device.token, user_id: @api_v1_device.user_id }
    end

    assert_response 201
  end

  test "should show api_v1_device" do
    get :show, id: @api_v1_device
    assert_response :success
  end

  test "should update api_v1_device" do
    put :update, id: @api_v1_device, api_v1_device: { name: @api_v1_device.name, token: @api_v1_device.token, user_id: @api_v1_device.user_id }
    assert_response 204
  end

  test "should destroy api_v1_device" do
    assert_difference('Api::V1::Device.count', -1) do
      delete :destroy, id: @api_v1_device
    end

    assert_response 204
  end
end
