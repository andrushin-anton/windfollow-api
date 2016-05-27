require 'test_helper'

class Api::V1::ReportsControllerTest < ActionController::TestCase
  setup do
    @api_v1_report = api_v1_reports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_v1_reports)
  end

  test "should create api_v1_report" do
    assert_difference('Api::V1::Report.count') do
      post :create, api_v1_report: { content: @api_v1_report.content, direction: @api_v1_report.direction, place: @api_v1_report.place, spot_id: @api_v1_report.spot_id, user_id: @api_v1_report.user_id, wind: @api_v1_report.wind }
    end

    assert_response 201
  end

  test "should show api_v1_report" do
    get :show, id: @api_v1_report
    assert_response :success
  end

  test "should update api_v1_report" do
    put :update, id: @api_v1_report, api_v1_report: { content: @api_v1_report.content, direction: @api_v1_report.direction, place: @api_v1_report.place, spot_id: @api_v1_report.spot_id, user_id: @api_v1_report.user_id, wind: @api_v1_report.wind }
    assert_response 204
  end

  test "should destroy api_v1_report" do
    assert_difference('Api::V1::Report.count', -1) do
      delete :destroy, id: @api_v1_report
    end

    assert_response 204
  end
end
