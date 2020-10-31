require 'test_helper'

class LikingTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    log_in_as(@user)
    @micropost = microposts(:ants)
  end
  
  test "like page" do
    get "/users/#{@user.id}/likes"
    assert_match @user.likes.count.to_s, response.body
    @user.likes.each do |like|
      assert_select "a[href=?]", user_path(like)
    end
  end
end
