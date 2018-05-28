require 'test_helper'

class WikiPicUploadsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get wiki_pic_uploads_create_url
    assert_response :success
  end

  test "should get destroy" do
    get wiki_pic_uploads_destroy_url
    assert_response :success
  end

end
