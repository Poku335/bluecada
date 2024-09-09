require "test_helper"

class PatientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @patient = patients(:one)
  end

  test "should get index" do
    get patients_url, as: :json
    assert_response :success
  end

  test "should create patient" do
    assert_difference("Patient.count") do
      post patients_url, params: { patient: { address_code_id: @patient.address_code_id, address_detail: @patient.address_detail, age: @patient.age, birth_date: @patient.birth_date, citizen_id: @patient.citizen_id, district_id: @patient.district_id, health_insurance_id: @patient.health_insurance_id, hos_no: @patient.hos_no, hospital_id: @patient.hospital_id, id_finding: @patient.id_finding, marital_status_id: @patient.marital_status_id, name: @patient.name, post_code_id: @patient.post_code_id, province_id: @patient.province_id, race_id: @patient.race_id, regis_date: @patient.regis_date, religion_id: @patient.religion_id, sex_id: @patient.sex_id, sub_distric_id: @patient.sub_distric_id } }, as: :json
    end

    assert_response :created
  end

  test "should show patient" do
    get patient_url(@patient), as: :json
    assert_response :success
  end

  test "should update patient" do
    patch patient_url(@patient), params: { patient: { address_code_id: @patient.address_code_id, address_detail: @patient.address_detail, age: @patient.age, birth_date: @patient.birth_date, citizen_id: @patient.citizen_id, district_id: @patient.district_id, health_insurance_id: @patient.health_insurance_id, hos_no: @patient.hos_no, hospital_id: @patient.hospital_id, id_finding: @patient.id_finding, marital_status_id: @patient.marital_status_id, name: @patient.name, post_code_id: @patient.post_code_id, province_id: @patient.province_id, race_id: @patient.race_id, regis_date: @patient.regis_date, religion_id: @patient.religion_id, sex_id: @patient.sex_id, sub_distric_id: @patient.sub_distric_id } }, as: :json
    assert_response :success
  end

  test "should destroy patient" do
    assert_difference("Patient.count", -1) do
      delete patient_url(@patient), as: :json
    end

    assert_response :no_content
  end
end
