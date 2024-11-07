require "application_system_test_case"

class EcogsTest < ApplicationSystemTestCase
  setup do
    @ecog = ecogs(:one)
  end

  test "visiting the index" do
    visit ecogs_url
    assert_selector "h1", text: "Ecogs"
  end

  test "should create ecog" do
    visit ecogs_url
    click_on "New ecog"

    fill_in "Code", with: @ecog.code
    fill_in "Name", with: @ecog.name
    click_on "Create Ecog"

    assert_text "Ecog was successfully created"
    click_on "Back"
  end

  test "should update Ecog" do
    visit ecog_url(@ecog)
    click_on "Edit this ecog", match: :first

    fill_in "Code", with: @ecog.code
    fill_in "Name", with: @ecog.name
    click_on "Update Ecog"

    assert_text "Ecog was successfully updated"
    click_on "Back"
  end

  test "should destroy Ecog" do
    visit ecog_url(@ecog)
    click_on "Destroy this ecog", match: :first

    assert_text "Ecog was successfully destroyed"
  end
end
