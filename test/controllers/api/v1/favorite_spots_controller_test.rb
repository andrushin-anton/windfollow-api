require 'test_helper'

class Api::V1::FavoriteSpotsControllerTest < ActionController::TestCase
  setup do
    @api_v1_favorite_spot = api_v1_favorite_spots(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_v1_favorite_spots)
  end

  test "should create api_v1_favorite_spot" do
    assert_difference('Api::V1::FavoriteSpot.count') do
      post :create, api_v1_favorite_spot: { spot_id: @api_v1_favorite_spot.spot_id, user_id: @api_v1_favorite_spot.user_id }
    end

    assert_response 201
  end

  test "should show api_v1_favorite_spot" do
    get :show, id: @api_v1_favorite_spot
    assert_response :success
  end

  test "should update api_v1_favorite_spot" do
    put :update, id: @api_v1_favorite_spot, api_v1_favorite_spot: { spot_id: @api_v1_favorite_spot.spot_id, user_id: @api_v1_favorite_spot.user_id }
    assert_response 204
  end

  test "should destroy api_v1_favorite_spot" do
    assert_difference('Api::V1::FavoriteSpot.count', -1) do
      delete :destroy, id: @api_v1_favorite_spot
    end

    assert_response 204
  end
end
