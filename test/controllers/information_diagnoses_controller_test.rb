require "test_helper"

class InformationDiagnosesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @information_diagnosis = information_diagnoses(:one)
  end

  test "should get index" do
    get information_diagnoses_url, as: :json
    assert_response :success
  end

  test "should create information_diagnosis" do
    assert_difference("InformationDiagnosis.count") do
      post information_diagnoses_url, params: { information_diagnosis: { tumor_marker: @information_diagnosis.tumor_marker, tumor_suppressor_gene: @information_diagnosis.tumor_suppressor_gene } }, as: :json
    end

    assert_response :created
  end

  test "should show information_diagnosis" do
    get information_diagnosis_url(@information_diagnosis), as: :json
    assert_response :success
  end

  test "should update information_diagnosis" do
    patch information_diagnosis_url(@information_diagnosis), params: { information_diagnosis: { tumor_marker: @information_diagnosis.tumor_marker, tumor_suppressor_gene: @information_diagnosis.tumor_suppressor_gene } }, as: :json
    assert_response :success
  end

  test "should destroy information_diagnosis" do
    assert_difference("InformationDiagnosis.count", -1) do
      delete information_diagnosis_url(@information_diagnosis), as: :json
    end

    assert_response :no_content
  end
end
