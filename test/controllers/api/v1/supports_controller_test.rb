require 'test_helper'

class Api::V1::SupportsControllerTest < ActionController::TestCase
  setup do
    @api_v1_support = api_v1_supports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_v1_supports)
  end

  test "should create api_v1_support" do
    assert_difference('Api::V1::Support.count') do
      post :create, api_v1_support: { details: @api_v1_support.details, message: @api_v1_support.message }
    end

    assert_response 201
  end

  test "should show api_v1_support" do
    get :show, id: @api_v1_support
    assert_response :success
  end

  test "should update api_v1_support" do
    put :update, id: @api_v1_support, api_v1_support: { details: @api_v1_support.details, message: @api_v1_support.message }
    assert_response 204
  end

  test "should destroy api_v1_support" do
    assert_difference('Api::V1::Support.count', -1) do
      delete :destroy, id: @api_v1_support
    end

    assert_response 204
  end
end
