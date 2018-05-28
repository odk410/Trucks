require "application_system_test_case"

class CelebWikisTest < ApplicationSystemTestCase
  setup do
    @celeb_wiki = celeb_wikis(:one)
  end

  test "visiting the index" do
    visit celeb_wikis_url
    assert_selector "h1", text: "Celeb Wikis"
  end

  test "creating a Celeb wiki" do
    visit celeb_wikis_url
    click_on "New Celeb Wiki"

    fill_in "Celebrity", with: @celeb_wiki.celebrity_id
    fill_in "Content", with: @celeb_wiki.content
    fill_in "User", with: @celeb_wiki.user_id
    click_on "Create Celeb wiki"

    assert_text "Celeb wiki was successfully created"
    click_on "Back"
  end

  test "updating a Celeb wiki" do
    visit celeb_wikis_url
    click_on "Edit", match: :first

    fill_in "Celebrity", with: @celeb_wiki.celebrity_id
    fill_in "Content", with: @celeb_wiki.content
    fill_in "User", with: @celeb_wiki.user_id
    click_on "Update Celeb wiki"

    assert_text "Celeb wiki was successfully updated"
    click_on "Back"
  end

  test "destroying a Celeb wiki" do
    visit celeb_wikis_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Celeb wiki was successfully destroyed"
  end
end
