require "test_helper"

class PostCodesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post_code = post_codes(:one)
  end

  test "should get index" do
    get post_codes_url, as: :json
    assert_response :success
  end

  test "should create post_code" do
    assert_difference("PostCode.count") do
      post post_codes_url, params: { post_code: { code: @post_code.code, district: @post_code.district, province: @post_code.province, sub_district: @post_code.sub_district } }, as: :json
    end

    assert_response :created
  end

  test "should show post_code" do
    get post_code_url(@post_code), as: :json
    assert_response :success
  end

  test "should update post_code" do
    patch post_code_url(@post_code), params: { post_code: { code: @post_code.code, district: @post_code.district, province: @post_code.province, sub_district: @post_code.sub_district } }, as: :json
    assert_response :success
  end

  test "should destroy post_code" do
    assert_difference("PostCode.count", -1) do
      delete post_code_url(@post_code), as: :json
    end

    assert_response :no_content
  end
end
