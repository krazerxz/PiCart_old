require 'test_helper'

class Api::BarcodesControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

end
