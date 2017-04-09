require 'test_helper'

class Api::V1::SensorsControllerTest < ActionController::TestCase
  test "should get in" do
    get :in
    assert_response :success
  end

end
