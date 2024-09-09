require "test_helper"

class LabsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lab = labs(:one)
  end

  test "should get index" do
    get labs_url, as: :json
    assert_response :success
  end

  test "should create lab" do
    assert_difference("Lab.count") do
      post labs_url, params: { lab: { code: @lab.code, name: @lab.name } }, as: :json
    end

    assert_response :created
  end

  test "should show lab" do
    get lab_url(@lab), as: :json
    assert_response :success
  end

  test "should update lab" do
    patch lab_url(@lab), params: { lab: { code: @lab.code, name: @lab.name } }, as: :json
    assert_response :success
  end

  test "should destroy lab" do
    assert_difference("Lab.count", -1) do
      delete lab_url(@lab), as: :json
    end

    assert_response :no_content
  end
end
