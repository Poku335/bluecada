require "test_helper"

class SexesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sex = sexes(:one)
  end

  test "should get index" do
    get sexes_url, as: :json
    assert_response :success
  end

  test "should create sex" do
    assert_difference("Sex.count") do
      post sexes_url, params: { sex: { code: @sex.code, name: @sex.name } }, as: :json
    end

    assert_response :created
  end

  test "should show sex" do
    get sex_url(@sex), as: :json
    assert_response :success
  end

  test "should update sex" do
    patch sex_url(@sex), params: { sex: { code: @sex.code, name: @sex.name } }, as: :json
    assert_response :success
  end

  test "should destroy sex" do
    assert_difference("Sex.count", -1) do
      delete sex_url(@sex), as: :json
    end

    assert_response :no_content
  end
end
