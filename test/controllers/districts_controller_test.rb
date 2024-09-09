require "test_helper"

class DistrictsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @district = districts(:one)
  end

  test "should get index" do
    get districts_url, as: :json
    assert_response :success
  end

  test "should create district" do
    assert_difference("District.count") do
      post districts_url, params: { district: { district_cnt: @district.district_cnt, district_eng_short: @district.district_eng_short, district_id: @district.district_id, district_thai_short: @district.district_thai_short, province_id: @district.province_id } }, as: :json
    end

    assert_response :created
  end

  test "should show district" do
    get district_url(@district), as: :json
    assert_response :success
  end

  test "should update district" do
    patch district_url(@district), params: { district: { district_cnt: @district.district_cnt, district_eng_short: @district.district_eng_short, district_id: @district.district_id, district_thai_short: @district.district_thai_short, province_id: @district.province_id } }, as: :json
    assert_response :success
  end

  test "should destroy district" do
    assert_difference("District.count", -1) do
      delete district_url(@district), as: :json
    end

    assert_response :no_content
  end
end
