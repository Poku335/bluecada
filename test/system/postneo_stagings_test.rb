require "application_system_test_case"

class PostneoStagingsTest < ApplicationSystemTestCase
  setup do
    @postneo_staging = postneo_stagings(:one)
  end

  test "visiting the index" do
    visit postneo_stagings_url
    assert_selector "h1", text: "Postneo stagings"
  end

  test "should create postneo staging" do
    visit postneo_stagings_url
    click_on "New postneo staging"

    fill_in "Code", with: @postneo_staging.code
    fill_in "Name", with: @postneo_staging.name
    click_on "Create Postneo staging"

    assert_text "Postneo staging was successfully created"
    click_on "Back"
  end

  test "should update Postneo staging" do
    visit postneo_staging_url(@postneo_staging)
    click_on "Edit this postneo staging", match: :first

    fill_in "Code", with: @postneo_staging.code
    fill_in "Name", with: @postneo_staging.name
    click_on "Update Postneo staging"

    assert_text "Postneo staging was successfully updated"
    click_on "Back"
  end

  test "should destroy Postneo staging" do
    visit postneo_staging_url(@postneo_staging)
    click_on "Destroy this postneo staging", match: :first

    assert_text "Postneo staging was successfully destroyed"
  end
end
