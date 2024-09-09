require "test_helper"

class AddressCodesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @address_code = address_codes(:one)
  end

  test "should get index" do
    get address_codes_url, as: :json
    assert_response :success
  end

  test "should create address_code" do
    assert_difference("AddressCode.count") do
      post address_codes_url, params: { address_code: { code: @address_code.code, district: @address_code.district, province: @address_code.province, sub_district: @address_code.sub_district } }, as: :json
    end

    assert_response :created
  end

  test "should show address_code" do
    get address_code_url(@address_code), as: :json
    assert_response :success
  end

  test "should update address_code" do
    patch address_code_url(@address_code), params: { address_code: { code: @address_code.code, district: @address_code.district, province: @address_code.province, sub_district: @address_code.sub_district } }, as: :json
    assert_response :success
  end

  test "should destroy address_code" do
    assert_difference("AddressCode.count", -1) do
      delete address_code_url(@address_code), as: :json
    end

    assert_response :no_content
  end
end
