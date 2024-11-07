require "application_system_test_case"

class BclcsTest < ApplicationSystemTestCase
  setup do
    @bclc = bclcs(:one)
  end

  test "visiting the index" do
    visit bclcs_url
    assert_selector "h1", text: "Bclcs"
  end

  test "should create bclc" do
    visit bclcs_url
    click_on "New bclc"

    fill_in "Code", with: @bclc.code
    fill_in "Name", with: @bclc.name
    click_on "Create Bclc"

    assert_text "Bclc was successfully created"
    click_on "Back"
  end

  test "should update Bclc" do
    visit bclc_url(@bclc)
    click_on "Edit this bclc", match: :first

    fill_in "Code", with: @bclc.code
    fill_in "Name", with: @bclc.name
    click_on "Update Bclc"

    assert_text "Bclc was successfully updated"
    click_on "Back"
  end

  test "should destroy Bclc" do
    visit bclc_url(@bclc)
    click_on "Destroy this bclc", match: :first

    assert_text "Bclc was successfully destroyed"
  end
end
