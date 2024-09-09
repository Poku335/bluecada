require "test_helper"

class CaseTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @case_type = case_types(:one)
  end

  test "should get index" do
    get case_types_url, as: :json
    assert_response :success
  end

  test "should create case_type" do
    assert_difference("CaseType.count") do
      post case_types_url, params: { case_type: { code: @case_type.code, name: @case_type.name } }, as: :json
    end

    assert_response :created
  end

  test "should show case_type" do
    get case_type_url(@case_type), as: :json
    assert_response :success
  end

  test "should update case_type" do
    patch case_type_url(@case_type), params: { case_type: { code: @case_type.code, name: @case_type.name } }, as: :json
    assert_response :success
  end

  test "should destroy case_type" do
    assert_difference("CaseType.count", -1) do
      delete case_type_url(@case_type), as: :json
    end

    assert_response :no_content
  end
end
