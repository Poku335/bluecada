require "test_helper"

class BasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @basis = bases(:one)
  end

  test "should get index" do
    get bases_url, as: :json
    assert_response :success
  end

  test "should create basis" do
    assert_difference("Basis.count") do
      post bases_url, params: { basis: { code: @basis.code, name: @basis.name } }, as: :json
    end

    assert_response :created
  end

  test "should show basis" do
    get basis_url(@basis), as: :json
    assert_response :success
  end

  test "should update basis" do
    patch basis_url(@basis), params: { basis: { code: @basis.code, name: @basis.name } }, as: :json
    assert_response :success
  end

  test "should destroy basis" do
    assert_difference("Basis.count", -1) do
      delete basis_url(@basis), as: :json
    end

    assert_response :no_content
  end
end
