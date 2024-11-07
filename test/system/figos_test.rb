require "application_system_test_case"

class FigosTest < ApplicationSystemTestCase
  setup do
    @figo = figos(:one)
  end

  test "visiting the index" do
    visit figos_url
    assert_selector "h1", text: "Figos"
  end

  test "should create figo" do
    visit figos_url
    click_on "New figo"

    fill_in "Code", with: @figo.code
    fill_in "Name", with: @figo.name
    click_on "Create Figo"

    assert_text "Figo was successfully created"
    click_on "Back"
  end

  test "should update Figo" do
    visit figo_url(@figo)
    click_on "Edit this figo", match: :first

    fill_in "Code", with: @figo.code
    fill_in "Name", with: @figo.name
    click_on "Update Figo"

    assert_text "Figo was successfully updated"
    click_on "Back"
  end

  test "should destroy Figo" do
    visit figo_url(@figo)
    click_on "Destroy this figo", match: :first

    assert_text "Figo was successfully destroyed"
  end
end
