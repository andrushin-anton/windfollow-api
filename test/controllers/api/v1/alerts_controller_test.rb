require 'test_helper'

class Api::V1::AlertsControllerTest < ActionController::TestCase
  setup do
    @api_v1_alert = api_v1_alerts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_v1_alerts)
  end

  test "should create api_v1_alert" do
    assert_difference('Api::V1::Alert.count') do
      post :create, api_v1_alert: { distance: @api_v1_alert.distance, time_alert: @api_v1_alert.time_alert, user_id: @api_v1_alert.user_id }
    end

    assert_response 201
  end

  test "should show api_v1_alert" do
    get :show, id: @api_v1_alert
    assert_response :success
  end

  test "should update api_v1_alert" do
    put :update, id: @api_v1_alert, api_v1_alert: { distance: @api_v1_alert.distance, time_alert: @api_v1_alert.time_alert, user_id: @api_v1_alert.user_id }
    assert_response 204
  end

  test "should destroy api_v1_alert" do
    assert_difference('Api::V1::Alert.count', -1) do
      delete :destroy, id: @api_v1_alert
    end

    assert_response 204
  end
end
