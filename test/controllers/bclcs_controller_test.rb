require "test_helper"

class BclcsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bclc = bclcs(:one)
  end

  test "should get index" do
    get bclcs_url
    assert_response :success
  end

  test "should get new" do
    get new_bclc_url
    assert_response :success
  end

  test "should create bclc" do
    assert_difference("Bclc.count") do
      post bclcs_url, params: { bclc: { code: @bclc.code, name: @bclc.name } }
    end

    assert_redirected_to bclc_url(Bclc.last)
  end

  test "should show bclc" do
    get bclc_url(@bclc)
    assert_response :success
  end

  test "should get edit" do
    get edit_bclc_url(@bclc)
    assert_response :success
  end

  test "should update bclc" do
    patch bclc_url(@bclc), params: { bclc: { code: @bclc.code, name: @bclc.name } }
    assert_redirected_to bclc_url(@bclc)
  end

  test "should destroy bclc" do
    assert_difference("Bclc.count", -1) do
      delete bclc_url(@bclc)
    end

    assert_redirected_to bclcs_url
  end
end
