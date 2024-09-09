require "test_helper"

class ImportPatientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @import_patient = import_patients(:one)
  end

  test "should get index" do
    get import_patients_url, as: :json
    assert_response :success
  end

  test "should create import_patient" do
    assert_difference("ImportPatient.count") do
      post import_patients_url, params: { import_patient: { date: @import_patient.date, error_patient_count: @import_patient.error_patient_count, existing_patient_count: @import_patient.existing_patient_count, new_patient_count: @import_patient.new_patient_count, total_patient_count: @import_patient.total_patient_count } }, as: :json
    end

    assert_response :created
  end

  test "should show import_patient" do
    get import_patient_url(@import_patient), as: :json
    assert_response :success
  end

  test "should update import_patient" do
    patch import_patient_url(@import_patient), params: { import_patient: { date: @import_patient.date, error_patient_count: @import_patient.error_patient_count, existing_patient_count: @import_patient.existing_patient_count, new_patient_count: @import_patient.new_patient_count, total_patient_count: @import_patient.total_patient_count } }, as: :json
    assert_response :success
  end

  test "should destroy import_patient" do
    assert_difference("ImportPatient.count", -1) do
      delete import_patient_url(@import_patient), as: :json
    end

    assert_response :no_content
  end
end
