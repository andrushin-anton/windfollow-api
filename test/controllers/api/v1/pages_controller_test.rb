require 'test_helper'

class Api::V1::PagesControllerTest < ActionController::TestCase
  setup do
    @api_v1_page = api_v1_pages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_v1_pages)
  end

  test "should create api_v1_page" do
    assert_difference('Api::V1::Page.count') do
      post :create, api_v1_page: { body: @api_v1_page.body, title: @api_v1_page.title }
    end

    assert_response 201
  end

  test "should show api_v1_page" do
    get :show, id: @api_v1_page
    assert_response :success
  end

  test "should update api_v1_page" do
    put :update, id: @api_v1_page, api_v1_page: { body: @api_v1_page.body, title: @api_v1_page.title }
    assert_response 204
  end

  test "should destroy api_v1_page" do
    assert_difference('Api::V1::Page.count', -1) do
      delete :destroy, id: @api_v1_page
    end

    assert_response 204
  end
end
