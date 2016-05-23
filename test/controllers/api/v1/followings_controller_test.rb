require 'test_helper'

class Api::V1::FollowingsControllerTest < ActionController::TestCase
  setup do
    @api_v1_following = api_v1_followings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_v1_followings)
  end

  test "should create api_v1_following" do
    assert_difference('Api::V1::Following.count') do
      post :create, api_v1_following: { following_id: @api_v1_following.following_id, user_id: @api_v1_following.user_id }
    end

    assert_response 201
  end

  test "should show api_v1_following" do
    get :show, id: @api_v1_following
    assert_response :success
  end

  test "should update api_v1_following" do
    put :update, id: @api_v1_following, api_v1_following: { following_id: @api_v1_following.following_id, user_id: @api_v1_following.user_id }
    assert_response 204
  end

  test "should destroy api_v1_following" do
    assert_difference('Api::V1::Following.count', -1) do
      delete :destroy, id: @api_v1_following
    end

    assert_response 204
  end
end
