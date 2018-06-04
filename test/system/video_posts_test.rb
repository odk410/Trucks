require "application_system_test_case"

class VideoPostsTest < ApplicationSystemTestCase
  setup do
    @video_post = video_posts(:one)
  end

  test "visiting the index" do
    visit video_posts_url
    assert_selector "h1", text: "Video Posts"
  end

  test "creating a Video post" do
    visit video_posts_url
    click_on "New Video Post"

    fill_in "Content", with: @video_post.content
    fill_in "Title", with: @video_post.title
    fill_in "Video", with: @video_post.video
    fill_in "Video Location", with: @video_post.video_location
    click_on "Create Video post"

    assert_text "Video post was successfully created"
    click_on "Back"
  end

  test "updating a Video post" do
    visit video_posts_url
    click_on "Edit", match: :first

    fill_in "Content", with: @video_post.content
    fill_in "Title", with: @video_post.title
    fill_in "Video", with: @video_post.video
    fill_in "Video Location", with: @video_post.video_location
    click_on "Update Video post"

    assert_text "Video post was successfully updated"
    click_on "Back"
  end

  test "destroying a Video post" do
    visit video_posts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Video post was successfully destroyed"
  end
end
