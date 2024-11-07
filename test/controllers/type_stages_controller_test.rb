require "test_helper"

class TypeStagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @type_stage = type_stages(:one)
  end

  test "should get index" do
    get type_stages_url
    assert_response :success
  end

  test "should get new" do
    get new_type_stage_url
    assert_response :success
  end

  test "should create type_stage" do
    assert_difference("TypeStage.count") do
      post type_stages_url, params: { type_stage: { code: @type_stage.code, name: @type_stage.name } }
    end

    assert_redirected_to type_stage_url(TypeStage.last)
  end

  test "should show type_stage" do
    get type_stage_url(@type_stage)
    assert_response :success
  end

  test "should get edit" do
    get edit_type_stage_url(@type_stage)
    assert_response :success
  end

  test "should update type_stage" do
    patch type_stage_url(@type_stage), params: { type_stage: { code: @type_stage.code, name: @type_stage.name } }
    assert_redirected_to type_stage_url(@type_stage)
  end

  test "should destroy type_stage" do
    assert_difference("TypeStage.count", -1) do
      delete type_stage_url(@type_stage)
    end

    assert_redirected_to type_stages_url
  end
end
