require "test_helper"

class ReligionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @religion = religions(:one)
  end

  test "should get index" do
    get religions_url, as: :json
    assert_response :success
  end

  test "should create religion" do
    assert_difference("Religion.count") do
      post religions_url, params: { religion: { code: @religion.code, name: @religion.name } }, as: :json
    end

    assert_response :created
  end

  test "should show religion" do
    get religion_url(@religion), as: :json
    assert_response :success
  end

  test "should update religion" do
    patch religion_url(@religion), params: { religion: { code: @religion.code, name: @religion.name } }, as: :json
    assert_response :success
  end

  test "should destroy religion" do
    assert_difference("Religion.count", -1) do
      delete religion_url(@religion), as: :json
    end

    assert_response :no_content
  end
end
