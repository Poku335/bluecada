require "test_helper"

class CancerFormsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cancer_form = cancer_forms(:one)
  end

  test "should get index" do
    get cancer_forms_url, as: :json
    assert_response :success
  end

  test "should create cancer_form" do
    assert_difference("CancerForm.count") do
      post cancer_forms_url, params: { cancer_form: { additional_field_jsonb: @cancer_form.additional_field_jsonb, cancer_form_status_id: @cancer_form.cancer_form_status_id, cancer_information_id: @cancer_form.cancer_information_id, current_user_id: @cancer_form.current_user_id, information_diagnose_id: @cancer_form.information_diagnose_id, is_editing: @cancer_form.is_editing, patient_id: @cancer_form.patient_id, primary: @cancer_form.primary, treatment_follow_up_id: @cancer_form.treatment_follow_up_id, treatment_information_id: @cancer_form.treatment_information_id, tumor_id: @cancer_form.tumor_id } }, as: :json
    end

    assert_response :created
  end

  test "should show cancer_form" do
    get cancer_form_url(@cancer_form), as: :json
    assert_response :success
  end

  test "should update cancer_form" do
    patch cancer_form_url(@cancer_form), params: { cancer_form: { additional_field_jsonb: @cancer_form.additional_field_jsonb, cancer_form_status_id: @cancer_form.cancer_form_status_id, cancer_information_id: @cancer_form.cancer_information_id, current_user_id: @cancer_form.current_user_id, information_diagnose_id: @cancer_form.information_diagnose_id, is_editing: @cancer_form.is_editing, patient_id: @cancer_form.patient_id, primary: @cancer_form.primary, treatment_follow_up_id: @cancer_form.treatment_follow_up_id, treatment_information_id: @cancer_form.treatment_information_id, tumor_id: @cancer_form.tumor_id } }, as: :json
    assert_response :success
  end

  test "should destroy cancer_form" do
    assert_difference("CancerForm.count", -1) do
      delete cancer_form_url(@cancer_form), as: :json
    end

    assert_response :no_content
  end
end
