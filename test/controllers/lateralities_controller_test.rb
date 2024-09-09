require "test_helper"

class LateralitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @laterality = lateralities(:one)
  end

  test "should get index" do
    get lateralities_url, as: :json
    assert_response :success
  end

  test "should create laterality" do
    assert_difference("Laterality.count") do
      post lateralities_url, params: { laterality: { code: @laterality.code, name: @laterality.name } }, as: :json
    end

    assert_response :created
  end

  test "should show laterality" do
    get laterality_url(@laterality), as: :json
    assert_response :success
  end

  test "should update laterality" do
    patch laterality_url(@laterality), params: { laterality: { code: @laterality.code, name: @laterality.name } }, as: :json
    assert_response :success
  end

  test "should destroy laterality" do
    assert_difference("Laterality.count", -1) do
      delete laterality_url(@laterality), as: :json
    end

    assert_response :no_content
  end
end
