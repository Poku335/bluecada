require "test_helper"

class BehaviorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @behavior = behaviors(:one)
  end

  test "should get index" do
    get behaviors_url, as: :json
    assert_response :success
  end

  test "should create behavior" do
    assert_difference("Behavior.count") do
      post behaviors_url, params: { behavior: { code: @behavior.code, name: @behavior.name } }, as: :json
    end

    assert_response :created
  end

  test "should show behavior" do
    get behavior_url(@behavior), as: :json
    assert_response :success
  end

  test "should update behavior" do
    patch behavior_url(@behavior), params: { behavior: { code: @behavior.code, name: @behavior.name } }, as: :json
    assert_response :success
  end

  test "should destroy behavior" do
    assert_difference("Behavior.count", -1) do
      delete behavior_url(@behavior), as: :json
    end

    assert_response :no_content
  end
end
