require 'test_helper'

class Api::V1::FollowersControllerTest < ActionController::TestCase
  setup do
    @api_v1_follower = api_v1_followers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_v1_followers)
  end

  test "should create api_v1_follower" do
    assert_difference('Api::V1::Follower.count') do
      post :create, api_v1_follower: { follower_id: @api_v1_follower.follower_id, user_id: @api_v1_follower.user_id }
    end

    assert_response 201
  end

  test "should show api_v1_follower" do
    get :show, id: @api_v1_follower
    assert_response :success
  end

  test "should update api_v1_follower" do
    put :update, id: @api_v1_follower, api_v1_follower: { follower_id: @api_v1_follower.follower_id, user_id: @api_v1_follower.user_id }
    assert_response 204
  end

  test "should destroy api_v1_follower" do
    assert_difference('Api::V1::Follower.count', -1) do
      delete :destroy, id: @api_v1_follower
    end

    assert_response 204
  end
end
