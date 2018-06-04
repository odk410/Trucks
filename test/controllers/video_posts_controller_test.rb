require 'test_helper'

class VideoPostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @video_post = video_posts(:one)
  end

  test "should get index" do
    get video_posts_url
    assert_response :success
  end

  test "should get new" do
    get new_video_post_url
    assert_response :success
  end

  test "should create video_post" do
    assert_difference('VideoPost.count') do
      post video_posts_url, params: { video_post: { content: @video_post.content, title: @video_post.title, video: @video_post.video, video_location: @video_post.video_location } }
    end

    assert_redirected_to video_post_url(VideoPost.last)
  end

  test "should show video_post" do
    get video_post_url(@video_post)
    assert_response :success
  end

  test "should get edit" do
    get edit_video_post_url(@video_post)
    assert_response :success
  end

  test "should update video_post" do
    patch video_post_url(@video_post), params: { video_post: { content: @video_post.content, title: @video_post.title, video: @video_post.video, video_location: @video_post.video_location } }
    assert_redirected_to video_post_url(@video_post)
  end

  test "should destroy video_post" do
    assert_difference('VideoPost.count', -1) do
      delete video_post_url(@video_post)
    end

    assert_redirected_to video_posts_url
  end
end
