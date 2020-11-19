require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end
  
  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {session: {email: "", password: ""}}
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  
  test "login with valid email/invalid password" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email:    @user.email,
                                          password: "invalid" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  
  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_equal cookies[:remember_token], assigns(:user).remember_token
  end
  
  test "login without remembering" do
    # cookieを保存してログイン
    log_in_as(@user, remember_me: '1')
    delete logout_path
    # cookieを削除してログイン
    log_in_as(@user, remember_me: '0')
    assert_empty cookies[:remember_token]
  end
end
