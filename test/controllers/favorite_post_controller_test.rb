require 'test_helper'

class FavoritePostControllerTest < ActionController::TestCase
  test "should get post_id:integer" do
    get :post_id:integer
    assert_response :success
  end

  test "should get user_id:integer" do
    get :user_id:integer
    assert_response :success
  end

end
