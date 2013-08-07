require 'test_helper'

class WorkoutsControllerTest < ActionController::TestCase
  test "should get day" do
    get :day
    assert_response :success
  end

end
