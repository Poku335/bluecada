require "test_helper"

class PresentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @present = presents(:one)
  end

  test "should get index" do
    get presents_url, as: :json
    assert_response :success
  end

  test "should create present" do
    assert_difference("Present.count") do
      post presents_url, params: { present: { code: @present.code, name: @present.name } }, as: :json
    end

    assert_response :created
  end

  test "should show present" do
    get present_url(@present), as: :json
    assert_response :success
  end

  test "should update present" do
    patch present_url(@present), params: { present: { code: @present.code, name: @present.name } }, as: :json
    assert_response :success
  end

  test "should destroy present" do
    assert_difference("Present.count", -1) do
      delete present_url(@present), as: :json
    end

    assert_response :no_content
  end
end
