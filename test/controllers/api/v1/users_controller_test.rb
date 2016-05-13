require 'test_helper'

class Api::V1::UsersControllerTest < ActionController::TestCase
  setup do
    @api_v1_user = api_v1_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_v1_users)
  end

  test "should create api_v1_user" do
    assert_difference('Api::V1::User.count') do
      post :create, api_v1_user: { email: @api_v1_user.email, first_name: @api_v1_user.first_name, last_name: @api_v1_user.last_name, password: @api_v1_user.password, rating: @api_v1_user.rating }
    end

    assert_response 201
  end

  test "should show api_v1_user" do
    get :show, id: @api_v1_user
    assert_response :success
  end

  test "should update api_v1_user" do
    put :update, id: @api_v1_user, api_v1_user: { email: @api_v1_user.email, first_name: @api_v1_user.first_name, last_name: @api_v1_user.last_name, password: @api_v1_user.password, rating: @api_v1_user.rating }
    assert_response 204
  end

  test "should destroy api_v1_user" do
    assert_difference('Api::V1::User.count', -1) do
      delete :destroy, id: @api_v1_user
    end

    assert_response 204
  end
end
