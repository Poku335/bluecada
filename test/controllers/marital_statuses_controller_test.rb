require "test_helper"

class MaritalStatusesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @marital_status = marital_statuses(:one)
  end

  test "should get index" do
    get marital_statuses_url, as: :json
    assert_response :success
  end

  test "should create marital_status" do
    assert_difference("MaritalStatus.count") do
      post marital_statuses_url, params: { marital_status: { code: @marital_status.code, name: @marital_status.name } }, as: :json
    end

    assert_response :created
  end

  test "should show marital_status" do
    get marital_status_url(@marital_status), as: :json
    assert_response :success
  end

  test "should update marital_status" do
    patch marital_status_url(@marital_status), params: { marital_status: { code: @marital_status.code, name: @marital_status.name } }, as: :json
    assert_response :success
  end

  test "should destroy marital_status" do
    assert_difference("MaritalStatus.count", -1) do
      delete marital_status_url(@marital_status), as: :json
    end

    assert_response :no_content
  end
end
