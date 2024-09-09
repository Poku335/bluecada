require "test_helper"

class TopographyCodesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @topography_code = topography_codes(:one)
  end

  test "should get index" do
    get topography_codes_url, as: :json
    assert_response :success
  end

  test "should create topography_code" do
    assert_difference("TopographyCode.count") do
      post topography_codes_url, params: { topography_code: { code: @topography_code.code, icd_10: @topography_code.icd_10, name: @topography_code.name } }, as: :json
    end

    assert_response :created
  end

  test "should show topography_code" do
    get topography_code_url(@topography_code), as: :json
    assert_response :success
  end

  test "should update topography_code" do
    patch topography_code_url(@topography_code), params: { topography_code: { code: @topography_code.code, icd_10: @topography_code.icd_10, name: @topography_code.name } }, as: :json
    assert_response :success
  end

  test "should destroy topography_code" do
    assert_difference("TopographyCode.count", -1) do
      delete topography_code_url(@topography_code), as: :json
    end

    assert_response :no_content
  end
end
