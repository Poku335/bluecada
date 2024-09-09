require "test_helper"

class DeathStatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @death_stat = death_stats(:one)
  end

  test "should get index" do
    get death_stats_url, as: :json
    assert_response :success
  end

  test "should create death_stat" do
    assert_difference("DeathStat.count") do
      post death_stats_url, params: { death_stat: { code: @death_stat.code, name: @death_stat.name } }, as: :json
    end

    assert_response :created
  end

  test "should show death_stat" do
    get death_stat_url(@death_stat), as: :json
    assert_response :success
  end

  test "should update death_stat" do
    patch death_stat_url(@death_stat), params: { death_stat: { code: @death_stat.code, name: @death_stat.name } }, as: :json
    assert_response :success
  end

  test "should destroy death_stat" do
    assert_difference("DeathStat.count", -1) do
      delete death_stat_url(@death_stat), as: :json
    end

    assert_response :no_content
  end
end
