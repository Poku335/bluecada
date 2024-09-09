require "test_helper"

class ExtentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @extent = extents(:one)
  end

  test "should get index" do
    get extents_url, as: :json
    assert_response :success
  end

  test "should create extent" do
    assert_difference("Extent.count") do
      post extents_url, params: { extent: { code: @extent.code, name: @extent.name } }, as: :json
    end

    assert_response :created
  end

  test "should show extent" do
    get extent_url(@extent), as: :json
    assert_response :success
  end

  test "should update extent" do
    patch extent_url(@extent), params: { extent: { code: @extent.code, name: @extent.name } }, as: :json
    assert_response :success
  end

  test "should destroy extent" do
    assert_difference("Extent.count", -1) do
      delete extent_url(@extent), as: :json
    end

    assert_response :no_content
  end
end
