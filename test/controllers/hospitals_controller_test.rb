require "test_helper"

class HospitalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hospital = hospitals(:one)
  end

  test "should get index" do
    get hospitals_url, as: :json
    assert_response :success
  end

  test "should create hospital" do
    assert_difference("Hospital.count") do
      post hospitals_url, params: { hospital: { code: @hospital.code, name: @hospital.name } }, as: :json
    end

    assert_response :created
  end

  test "should show hospital" do
    get hospital_url(@hospital), as: :json
    assert_response :success
  end

  test "should update hospital" do
    patch hospital_url(@hospital), params: { hospital: { code: @hospital.code, name: @hospital.name } }, as: :json
    assert_response :success
  end

  test "should destroy hospital" do
    assert_difference("Hospital.count", -1) do
      delete hospital_url(@hospital), as: :json
    end

    assert_response :no_content
  end
end
