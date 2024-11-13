require "application_system_test_case"

class PostneosTest < ApplicationSystemTestCase
  setup do
    @postneo = postneos(:one)
  end

  test "visiting the index" do
    visit postneos_url
    assert_selector "h1", text: "Postneos"
  end

  test "should create postneo" do
    visit postneos_url
    click_on "New postneo"

    fill_in "Code", with: @postneo.code
    fill_in "Name", with: @postneo.name
    click_on "Create Postneo"

    assert_text "Postneo was successfully created"
    click_on "Back"
  end

  test "should update Postneo" do
    visit postneo_url(@postneo)
    click_on "Edit this postneo", match: :first

    fill_in "Code", with: @postneo.code
    fill_in "Name", with: @postneo.name
    click_on "Update Postneo"

    assert_text "Postneo was successfully updated"
    click_on "Back"
  end

  test "should destroy Postneo" do
    visit postneo_url(@postneo)
    click_on "Destroy this postneo", match: :first

    assert_text "Postneo was successfully destroyed"
  end
end
