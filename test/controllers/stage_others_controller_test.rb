require "test_helper"

class StageOthersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stage_other = stage_others(:one)
  end

  test "should get index" do
    get stage_others_url, as: :json
    assert_response :success
  end

  test "should create stage_other" do
    assert_difference("StageOther.count") do
      post stage_others_url, params: { stage_other: { code: @stage_other.code, name: @stage_other.name } }, as: :json
    end

    assert_response :created
  end

  test "should show stage_other" do
    get stage_other_url(@stage_other), as: :json
    assert_response :success
  end

  test "should update stage_other" do
    patch stage_other_url(@stage_other), params: { stage_other: { code: @stage_other.code, name: @stage_other.name } }, as: :json
    assert_response :success
  end

  test "should destroy stage_other" do
    assert_difference("StageOther.count", -1) do
      delete stage_other_url(@stage_other), as: :json
    end

    assert_response :no_content
  end
end
