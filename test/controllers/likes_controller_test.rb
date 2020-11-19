require 'test_helper'
class LikesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
    @micropost = microposts(:ants)
  end
  
  test "should redirect like when not logged in" do
    assert_no_difference 'Like.count' do
      post "/microposts/#{@micropost.id}/add"
    end
    assert_redirected_to login_url
  end
  
  test "should redirect unlike when not logged in" do
    assert_no_difference 'Like.count' do
      delete "/microposts/#{@micropost.id}/add"
    end
    assert_redirected_to login_url
  end
  
  test "should like and unlike a post" do
    log_in_as(@user)
    assert_difference '@user.likes.count', 1 do
      post "/microposts/#{@micropost.id}/add"
    end
    assert_difference '@user.likes.count', -1 do
      delete "/microposts/#{@micropost.id}/add"
    end
  end

end
