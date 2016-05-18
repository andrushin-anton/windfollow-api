require 'test_helper'

class Api::V1::SportsControllerTest < ActionController::TestCase
  setup do
    @api_v1_sport = api_v1_sports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_v1_sports)
  end

  test "should create api_v1_sport" do
    assert_difference('Api::V1::Sport.count') do
      post :create, api_v1_sport: { name: @api_v1_sport.name }
    end

    assert_response 201
  end

  test "should show api_v1_sport" do
    get :show, id: @api_v1_sport
    assert_response :success
  end

  test "should update api_v1_sport" do
    put :update, id: @api_v1_sport, api_v1_sport: { name: @api_v1_sport.name }
    assert_response 204
  end

  test "should destroy api_v1_sport" do
    assert_difference('Api::V1::Sport.count', -1) do
      delete :destroy, id: @api_v1_sport
    end

    assert_response 204
  end
end
