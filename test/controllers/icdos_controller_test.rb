require "test_helper"

class IcdosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @icdo = icdos(:one)
  end

  test "should get index" do
    get icdos_url, as: :json
    assert_response :success
  end

  test "should create icdo" do
    assert_difference("Icdo.count") do
      post icdos_url, params: { icdo: { beh: @icdo.beh, cancer_type: @icdo.cancer_type, icdo_32: @icdo.icdo_32, icdo_32_c: @icdo.icdo_32_c, idd: @icdo.idd, level: @icdo.level, term_raw: @icdo.term_raw, term_used: @icdo.term_used } }, as: :json
    end

    assert_response :created
  end

  test "should show icdo" do
    get icdo_url(@icdo), as: :json
    assert_response :success
  end

  test "should update icdo" do
    patch icdo_url(@icdo), params: { icdo: { beh: @icdo.beh, cancer_type: @icdo.cancer_type, icdo_32: @icdo.icdo_32, icdo_32_c: @icdo.icdo_32_c, idd: @icdo.idd, level: @icdo.level, term_raw: @icdo.term_raw, term_used: @icdo.term_used } }, as: :json
    assert_response :success
  end

  test "should destroy icdo" do
    assert_difference("Icdo.count", -1) do
      delete icdo_url(@icdo), as: :json
    end

    assert_response :no_content
  end
end
