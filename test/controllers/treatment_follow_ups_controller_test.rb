require "test_helper"

class TreatmentFollowUpsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @treatment_follow_up = treatment_follow_ups(:one)
  end

  test "should get index" do
    get treatment_follow_ups_url, as: :json
    assert_response :success
  end

  test "should create treatment_follow_up" do
    assert_difference("TreatmentFollowUp.count") do
      post treatment_follow_ups_url, params: { treatment_follow_up: { date_refer_from: @treatment_follow_up.date_refer_from, date_refer_to: @treatment_follow_up.date_refer_to, death_stat_id: @treatment_follow_up.death_stat_id, dls: @treatment_follow_up.dls, present_id: @treatment_follow_up.present_id, refer_from_id: @treatment_follow_up.refer_from_id, refer_to_id: @treatment_follow_up.refer_to_id } }, as: :json
    end

    assert_response :created
  end

  test "should show treatment_follow_up" do
    get treatment_follow_up_url(@treatment_follow_up), as: :json
    assert_response :success
  end

  test "should update treatment_follow_up" do
    patch treatment_follow_up_url(@treatment_follow_up), params: { treatment_follow_up: { date_refer_from: @treatment_follow_up.date_refer_from, date_refer_to: @treatment_follow_up.date_refer_to, death_stat_id: @treatment_follow_up.death_stat_id, dls: @treatment_follow_up.dls, present_id: @treatment_follow_up.present_id, refer_from_id: @treatment_follow_up.refer_from_id, refer_to_id: @treatment_follow_up.refer_to_id } }, as: :json
    assert_response :success
  end

  test "should destroy treatment_follow_up" do
    assert_difference("TreatmentFollowUp.count", -1) do
      delete treatment_follow_up_url(@treatment_follow_up), as: :json
    end

    assert_response :no_content
  end
end
