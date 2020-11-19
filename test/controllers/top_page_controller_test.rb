require 'test_helper'

class TopPageControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Incostagram"
  end
  
  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "Incostagramとは？ | Incostagram"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "コンタクト | Incostagram"
  end
end
