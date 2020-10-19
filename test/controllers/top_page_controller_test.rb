require 'test_helper'

class TopPageControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get top_page_home_url
    assert_response :success
    assert_select "title", "Incostagram"
  end
  
  test "should get about" do
    get top_page_about_url
    assert_response :success
    assert_select "title", "About | Incostagram"
  end

end
