require 'test_helper'

class Api::V1::ReportImageCommentsControllerTest < ActionController::TestCase
  setup do
    @api_v1_report_image_comment = api_v1_report_image_comments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_v1_report_image_comments)
  end

  test "should create api_v1_report_image_comment" do
    assert_difference('Api::V1::ReportImageComment.count') do
      post :create, api_v1_report_image_comment: { content: @api_v1_report_image_comment.content, report_image_id: @api_v1_report_image_comment.report_image_id, user_id: @api_v1_report_image_comment.user_id }
    end

    assert_response 201
  end

  test "should show api_v1_report_image_comment" do
    get :show, id: @api_v1_report_image_comment
    assert_response :success
  end

  test "should update api_v1_report_image_comment" do
    put :update, id: @api_v1_report_image_comment, api_v1_report_image_comment: { content: @api_v1_report_image_comment.content, report_image_id: @api_v1_report_image_comment.report_image_id, user_id: @api_v1_report_image_comment.user_id }
    assert_response 204
  end

  test "should destroy api_v1_report_image_comment" do
    assert_difference('Api::V1::ReportImageComment.count', -1) do
      delete :destroy, id: @api_v1_report_image_comment
    end

    assert_response 204
  end
end
