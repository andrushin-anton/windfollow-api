require 'test_helper'

class Api::V1::MessagesControllerTest < ActionController::TestCase
  setup do
    @api_v1_message = api_v1_messages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_v1_messages)
  end

  test "should create api_v1_message" do
    assert_difference('Api::V1::Message.count') do
      post :create, api_v1_message: { content: @api_v1_message.content, recepient_id: @api_v1_message.recepient_id, sender_id: @api_v1_message.sender_id }
    end

    assert_response 201
  end

  test "should show api_v1_message" do
    get :show, id: @api_v1_message
    assert_response :success
  end

  test "should update api_v1_message" do
    put :update, id: @api_v1_message, api_v1_message: { content: @api_v1_message.content, recepient_id: @api_v1_message.recepient_id, sender_id: @api_v1_message.sender_id }
    assert_response 204
  end

  test "should destroy api_v1_message" do
    assert_difference('Api::V1::Message.count', -1) do
      delete :destroy, id: @api_v1_message
    end

    assert_response 204
  end
end
