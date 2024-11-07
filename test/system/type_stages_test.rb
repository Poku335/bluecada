require "application_system_test_case"

class TypeStagesTest < ApplicationSystemTestCase
  setup do
    @type_stage = type_stages(:one)
  end

  test "visiting the index" do
    visit type_stages_url
    assert_selector "h1", text: "Type stages"
  end

  test "should create type stage" do
    visit type_stages_url
    click_on "New type stage"

    fill_in "Code", with: @type_stage.code
    fill_in "Name", with: @type_stage.name
    click_on "Create Type stage"

    assert_text "Type stage was successfully created"
    click_on "Back"
  end

  test "should update Type stage" do
    visit type_stage_url(@type_stage)
    click_on "Edit this type stage", match: :first

    fill_in "Code", with: @type_stage.code
    fill_in "Name", with: @type_stage.name
    click_on "Update Type stage"

    assert_text "Type stage was successfully updated"
    click_on "Back"
  end

  test "should destroy Type stage" do
    visit type_stage_url(@type_stage)
    click_on "Destroy this type stage", match: :first

    assert_text "Type stage was successfully destroyed"
  end
end
