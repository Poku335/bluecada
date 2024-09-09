require "test_helper"

class TreatmentInformationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @treatment_information = treatment_informations(:one)
  end

  test "should get index" do
    get treatment_informations_url, as: :json
    assert_response :success
  end

  test "should create treatment_information" do
    assert_difference("TreatmentInformation.count") do
      post treatment_informations_url, params: { treatment_information: { date_bone_scan: @treatment_information.date_bone_scan, date_chemo: @treatment_information.date_chemo, date_hormone: @treatment_information.date_hormone, date_immu: @treatment_information.date_immu, date_inter_the: @treatment_information.date_inter_the, date_nuclear: @treatment_information.date_nuclear, date_radia: @treatment_information.date_radia, date_stem_cell: @treatment_information.date_stem_cell, date_surg: @treatment_information.date_surg, date_target: @treatment_information.date_target, is_bone_scan: @treatment_information.is_bone_scan, is_chemo: @treatment_information.is_chemo, is_hormone: @treatment_information.is_hormone, is_immu: @treatment_information.is_immu, is_inter_the: @treatment_information.is_inter_the, is_nuclear: @treatment_information.is_nuclear, is_radia: @treatment_information.is_radia, is_stem_cell: @treatment_information.is_stem_cell, is_supportive: @treatment_information.is_supportive, is_surg: @treatment_information.is_surg, is_target: @treatment_information.is_target, is_treatment: @treatment_information.is_treatment } }, as: :json
    end

    assert_response :created
  end

  test "should show treatment_information" do
    get treatment_information_url(@treatment_information), as: :json
    assert_response :success
  end

  test "should update treatment_information" do
    patch treatment_information_url(@treatment_information), params: { treatment_information: { date_bone_scan: @treatment_information.date_bone_scan, date_chemo: @treatment_information.date_chemo, date_hormone: @treatment_information.date_hormone, date_immu: @treatment_information.date_immu, date_inter_the: @treatment_information.date_inter_the, date_nuclear: @treatment_information.date_nuclear, date_radia: @treatment_information.date_radia, date_stem_cell: @treatment_information.date_stem_cell, date_surg: @treatment_information.date_surg, date_target: @treatment_information.date_target, is_bone_scan: @treatment_information.is_bone_scan, is_chemo: @treatment_information.is_chemo, is_hormone: @treatment_information.is_hormone, is_immu: @treatment_information.is_immu, is_inter_the: @treatment_information.is_inter_the, is_nuclear: @treatment_information.is_nuclear, is_radia: @treatment_information.is_radia, is_stem_cell: @treatment_information.is_stem_cell, is_supportive: @treatment_information.is_supportive, is_surg: @treatment_information.is_surg, is_target: @treatment_information.is_target, is_treatment: @treatment_information.is_treatment } }, as: :json
    assert_response :success
  end

  test "should destroy treatment_information" do
    assert_difference("TreatmentInformation.count", -1) do
      delete treatment_information_url(@treatment_information), as: :json
    end

    assert_response :no_content
  end
end
