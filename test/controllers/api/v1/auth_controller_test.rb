require 'test_helper'

class Api::V1::AuthControllerTest < ActionController::TestCase
  test "should get token" do
    get :token
    assert_response :success
  end

end
