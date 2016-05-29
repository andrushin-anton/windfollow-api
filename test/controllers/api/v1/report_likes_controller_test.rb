require 'test_helper'

class Api::V1::ReportLikesControllerTest < ActionController::TestCase
  setup do
    @api_v1_report_like = api_v1_report_likes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_v1_report_likes)
  end

  test "should create api_v1_report_like" do
    assert_difference('Api::V1::ReportLike.count') do
      post :create, api_v1_report_like: { report_id: @api_v1_report_like.report_id, user_id: @api_v1_report_like.user_id }
    end

    assert_response 201
  end

  test "should show api_v1_report_like" do
    get :show, id: @api_v1_report_like
    assert_response :success
  end

  test "should update api_v1_report_like" do
    put :update, id: @api_v1_report_like, api_v1_report_like: { report_id: @api_v1_report_like.report_id, user_id: @api_v1_report_like.user_id }
    assert_response 204
  end

  test "should destroy api_v1_report_like" do
    assert_difference('Api::V1::ReportLike.count', -1) do
      delete :destroy, id: @api_v1_report_like
    end

    assert_response 204
  end
end
