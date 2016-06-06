require 'test_helper'

class Api::V1::SpotEstimatesControllerTest < ActionController::TestCase
  setup do
    @api_v1_spot_estimate = api_v1_spot_estimates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_v1_spot_estimates)
  end

  test "should create api_v1_spot_estimate" do
    assert_difference('Api::V1::SpotEstimate.count') do
      post :create, api_v1_spot_estimate: { best_month: @api_v1_spot_estimate.best_month, level: @api_v1_spot_estimate.level, rating: @api_v1_spot_estimate.rating, sport: @api_v1_spot_estimate.sport, spot_id: @api_v1_spot_estimate.spot_id, user_id: @api_v1_spot_estimate.user_id, wave: @api_v1_spot_estimate.wave }
    end

    assert_response 201
  end

  test "should show api_v1_spot_estimate" do
    get :show, id: @api_v1_spot_estimate
    assert_response :success
  end

  test "should update api_v1_spot_estimate" do
    put :update, id: @api_v1_spot_estimate, api_v1_spot_estimate: { best_month: @api_v1_spot_estimate.best_month, level: @api_v1_spot_estimate.level, rating: @api_v1_spot_estimate.rating, sport: @api_v1_spot_estimate.sport, spot_id: @api_v1_spot_estimate.spot_id, user_id: @api_v1_spot_estimate.user_id, wave: @api_v1_spot_estimate.wave }
    assert_response 204
  end

  test "should destroy api_v1_spot_estimate" do
    assert_difference('Api::V1::SpotEstimate.count', -1) do
      delete :destroy, id: @api_v1_spot_estimate
    end

    assert_response 204
  end
end
