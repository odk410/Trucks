require 'test_helper'

class CelebWikisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @celeb_wiki = celeb_wikis(:one)
  end

  test "should get index" do
    get celeb_wikis_url
    assert_response :success
  end

  test "should get new" do
    get new_celeb_wiki_url
    assert_response :success
  end

  test "should create celeb_wiki" do
    assert_difference('CelebWiki.count') do
      post celeb_wikis_url, params: { celeb_wiki: { celebrity_id: @celeb_wiki.celebrity_id, content: @celeb_wiki.content, user_id: @celeb_wiki.user_id } }
    end

    assert_redirected_to celeb_wiki_url(CelebWiki.last)
  end

  test "should show celeb_wiki" do
    get celeb_wiki_url(@celeb_wiki)
    assert_response :success
  end

  test "should get edit" do
    get edit_celeb_wiki_url(@celeb_wiki)
    assert_response :success
  end

  test "should update celeb_wiki" do
    patch celeb_wiki_url(@celeb_wiki), params: { celeb_wiki: { celebrity_id: @celeb_wiki.celebrity_id, content: @celeb_wiki.content, user_id: @celeb_wiki.user_id } }
    assert_redirected_to celeb_wiki_url(@celeb_wiki)
  end

  test "should destroy celeb_wiki" do
    assert_difference('CelebWiki.count', -1) do
      delete celeb_wiki_url(@celeb_wiki)
    end

    assert_redirected_to celeb_wikis_url
  end
end
