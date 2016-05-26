require 'test_helper'

class Api::V1::SpotsControllerTest < ActionController::TestCase
  setup do
    @api_v1_spot = api_v1_spots(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_v1_spots)
  end

  test "should create api_v1_spot" do
    assert_difference('Api::V1::Spot.count') do
      post :create, api_v1_spot: { best_month: @api_v1_spot.best_month, city: @api_v1_spot.city, country: @api_v1_spot.country, geo_lat: @api_v1_spot.geo_lat, geo_lon: @api_v1_spot.geo_lon, level: @api_v1_spot.level, name: @api_v1_spot.name, rating: @api_v1_spot.rating, sport: @api_v1_spot.sport, user_id: @api_v1_spot.user_id, wave: @api_v1_spot.wave }
    end

    assert_response 201
  end

  test "should show api_v1_spot" do
    get :show, id: @api_v1_spot
    assert_response :success
  end

  test "should update api_v1_spot" do
    put :update, id: @api_v1_spot, api_v1_spot: { best_month: @api_v1_spot.best_month, city: @api_v1_spot.city, country: @api_v1_spot.country, geo_lat: @api_v1_spot.geo_lat, geo_lon: @api_v1_spot.geo_lon, level: @api_v1_spot.level, name: @api_v1_spot.name, rating: @api_v1_spot.rating, sport: @api_v1_spot.sport, user_id: @api_v1_spot.user_id, wave: @api_v1_spot.wave }
    assert_response 204
  end

  test "should destroy api_v1_spot" do
    assert_difference('Api::V1::Spot.count', -1) do
      delete :destroy, id: @api_v1_spot
    end

    assert_response 204
  end
end
