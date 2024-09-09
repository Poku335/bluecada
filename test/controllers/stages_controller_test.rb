require "test_helper"

class StagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stage = stages(:one)
  end

  test "should get index" do
    get stages_url, as: :json
    assert_response :success
  end

  test "should create stage" do
    assert_difference("Stage.count") do
      post stages_url, params: { stage: { code: @stage.code, name: @stage.name } }, as: :json
    end

    assert_response :created
  end

  test "should show stage" do
    get stage_url(@stage), as: :json
    assert_response :success
  end

  test "should update stage" do
    patch stage_url(@stage), params: { stage: { code: @stage.code, name: @stage.name } }, as: :json
    assert_response :success
  end

  test "should destroy stage" do
    assert_difference("Stage.count", -1) do
      delete stage_url(@stage), as: :json
    end

    assert_response :no_content
  end
end
