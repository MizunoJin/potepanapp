require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "",
                                              email: "foo@invalid",
                                               } }

    assert_template 'users/edit'
    assert_select "div.alert", count: 1
  end
  
  test "unsuccessful password_edit" do
    log_in_as(@user)
    get "/users/#{@user.id}/password_edit"
    assert_template 'users/password_edit'
    patch "/users/#{@user.id}/password_update", params: { user: { current_password: "",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'users/password_edit'
    assert_select "div.alert", count: 1
  end
  
  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    name  = "Foo Bar"
    email = "foo@bar.com"
    introduction = "introduction"
    username = "username"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              introduction: introduction,
                                              username: username } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
    assert_equal introduction,  @user.introduction
    assert_equal username, @user.username
  end
  
  test "successful password_edit with friendly forwarding" do
    get "/users/#{@user.id}/password_edit"
    log_in_as(@user)
    assert_redirected_to "/users/#{@user.id}/password_edit"
    current_password  = "password"
    new_password = "hogehoge"
    patch "/users/#{@user.id}/password_update", 
                            params: { user: { current_password:  current_password,
                                              new_password: new_password,
                                              new_password_confirmation:  new_password,
                                               } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert @user.authenticate(new_password) 
  end
end
