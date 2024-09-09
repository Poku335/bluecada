require "test_helper"

class HealthInsurancesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @health_insurance = health_insurances(:one)
  end

  test "should get index" do
    get health_insurances_url, as: :json
    assert_response :success
  end

  test "should create health_insurance" do
    assert_difference("HealthInsurance.count") do
      post health_insurances_url, params: { health_insurance: { code: @health_insurance.code, name: @health_insurance.name } }, as: :json
    end

    assert_response :created
  end

  test "should show health_insurance" do
    get health_insurance_url(@health_insurance), as: :json
    assert_response :success
  end

  test "should update health_insurance" do
    patch health_insurance_url(@health_insurance), params: { health_insurance: { code: @health_insurance.code, name: @health_insurance.name } }, as: :json
    assert_response :success
  end

  test "should destroy health_insurance" do
    assert_difference("HealthInsurance.count", -1) do
      delete health_insurance_url(@health_insurance), as: :json
    end

    assert_response :no_content
  end
end
