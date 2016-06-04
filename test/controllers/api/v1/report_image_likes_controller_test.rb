require 'test_helper'

class Api::V1::ReportImageLikesControllerTest < ActionController::TestCase
  setup do
    @api_v1_report_image_like = api_v1_report_image_likes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_v1_report_image_likes)
  end

  test "should create api_v1_report_image_like" do
    assert_difference('Api::V1::ReportImageLike.count') do
      post :create, api_v1_report_image_like: { report_image_id: @api_v1_report_image_like.report_image_id, user_id: @api_v1_report_image_like.user_id }
    end

    assert_response 201
  end

  test "should show api_v1_report_image_like" do
    get :show, id: @api_v1_report_image_like
    assert_response :success
  end

  test "should update api_v1_report_image_like" do
    put :update, id: @api_v1_report_image_like, api_v1_report_image_like: { report_image_id: @api_v1_report_image_like.report_image_id, user_id: @api_v1_report_image_like.user_id }
    assert_response 204
  end

  test "should destroy api_v1_report_image_like" do
    assert_difference('Api::V1::ReportImageLike.count', -1) do
      delete :destroy, id: @api_v1_report_image_like
    end

    assert_response 204
  end
end
