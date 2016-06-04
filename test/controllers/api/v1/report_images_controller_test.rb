require 'test_helper'

class Api::V1::ReportImagesControllerTest < ActionController::TestCase
  setup do
    @api_v1_report_image = api_v1_report_images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_v1_report_images)
  end

  test "should create api_v1_report_image" do
    assert_difference('Api::V1::ReportImage.count') do
      post :create, api_v1_report_image: { report_id: @api_v1_report_image.report_id, user_id: @api_v1_report_image.user_id }
    end

    assert_response 201
  end

  test "should show api_v1_report_image" do
    get :show, id: @api_v1_report_image
    assert_response :success
  end

  test "should update api_v1_report_image" do
    put :update, id: @api_v1_report_image, api_v1_report_image: { report_id: @api_v1_report_image.report_id, user_id: @api_v1_report_image.user_id }
    assert_response 204
  end

  test "should destroy api_v1_report_image" do
    assert_difference('Api::V1::ReportImage.count', -1) do
      delete :destroy, id: @api_v1_report_image
    end

    assert_response 204
  end
end
