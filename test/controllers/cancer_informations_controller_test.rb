require "test_helper"

class CancerInformationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cancer_information = cancer_informations(:one)
  end

  test "should get index" do
    get cancer_informations_url, as: :json
    assert_response :success
  end

  test "should create cancer_information" do
    assert_difference("CancerInformation.count") do
      post cancer_informations_url, params: { cancer_information: { age_at_diagnosis: @cancer_information.age_at_diagnosis, basis_id: @cancer_information.basis_id, behavior_id: @cancer_information.behavior_id, extent_id: @cancer_information.extent_id, grad_id: @cancer_information.grad_id, icd_10: @cancer_information.icd_10, icdo_id: @cancer_information.icdo_id, is_recrr: @cancer_information.is_recrr, lab_date: @cancer_information.lab_date, lab_id: @cancer_information.lab_id, lab_num: @cancer_information.lab_num, laterality_id: @cancer_information.laterality_id, m_stage: @cancer_information.m_stage, metastasis_site_id: @cancer_information.metastasis_site_id, morphology_description: @cancer_information.morphology_description, n_stage: @cancer_information.n_stage, recurr_date: @cancer_information.recurr_date, stage_id: @cancer_information.stage_id, stage_other_id: @cancer_information.stage_other_id, t_stage: @cancer_information.t_stage, topography_code_id: @cancer_information.topography_code_id, topography_description: @cancer_information.topography_description } }, as: :json
    end

    assert_response :created
  end

  test "should show cancer_information" do
    get cancer_information_url(@cancer_information), as: :json
    assert_response :success
  end

  test "should update cancer_information" do
    patch cancer_information_url(@cancer_information), params: { cancer_information: { age_at_diagnosis: @cancer_information.age_at_diagnosis, basis_id: @cancer_information.basis_id, behavior_id: @cancer_information.behavior_id, extent_id: @cancer_information.extent_id, grad_id: @cancer_information.grad_id, icd_10: @cancer_information.icd_10, icdo_id: @cancer_information.icdo_id, is_recrr: @cancer_information.is_recrr, lab_date: @cancer_information.lab_date, lab_id: @cancer_information.lab_id, lab_num: @cancer_information.lab_num, laterality_id: @cancer_information.laterality_id, m_stage: @cancer_information.m_stage, metastasis_site_id: @cancer_information.metastasis_site_id, morphology_description: @cancer_information.morphology_description, n_stage: @cancer_information.n_stage, recurr_date: @cancer_information.recurr_date, stage_id: @cancer_information.stage_id, stage_other_id: @cancer_information.stage_other_id, t_stage: @cancer_information.t_stage, topography_code_id: @cancer_information.topography_code_id, topography_description: @cancer_information.topography_description } }, as: :json
    assert_response :success
  end

  test "should destroy cancer_information" do
    assert_difference("CancerInformation.count", -1) do
      delete cancer_information_url(@cancer_information), as: :json
    end

    assert_response :no_content
  end
end
