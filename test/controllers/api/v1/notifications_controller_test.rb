require 'test_helper'

class Api::V1::NotificationsControllerTest < ActionController::TestCase
  setup do
    @api_v1_notification = api_v1_notifications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_v1_notifications)
  end

  test "should create api_v1_notification" do
    assert_difference('Api::V1::Notification.count') do
      post :create, api_v1_notification: { content: @api_v1_notification.content, object_id: @api_v1_notification.object_id, type: @api_v1_notification.type, user_id: @api_v1_notification.user_id }
    end

    assert_response 201
  end

  test "should show api_v1_notification" do
    get :show, id: @api_v1_notification
    assert_response :success
  end

  test "should update api_v1_notification" do
    put :update, id: @api_v1_notification, api_v1_notification: { content: @api_v1_notification.content, object_id: @api_v1_notification.object_id, type: @api_v1_notification.type, user_id: @api_v1_notification.user_id }
    assert_response 204
  end

  test "should destroy api_v1_notification" do
    assert_difference('Api::V1::Notification.count', -1) do
      delete :destroy, id: @api_v1_notification
    end

    assert_response 204
  end
end
