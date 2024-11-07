require "test_helper"

class EcogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ecog = ecogs(:one)
  end

  test "should get index" do
    get ecogs_url
    assert_response :success
  end

  test "should get new" do
    get new_ecog_url
    assert_response :success
  end

  test "should create ecog" do
    assert_difference("Ecog.count") do
      post ecogs_url, params: { ecog: { code: @ecog.code, name: @ecog.name } }
    end

    assert_redirected_to ecog_url(Ecog.last)
  end

  test "should show ecog" do
    get ecog_url(@ecog)
    assert_response :success
  end

  test "should get edit" do
    get edit_ecog_url(@ecog)
    assert_response :success
  end

  test "should update ecog" do
    patch ecog_url(@ecog), params: { ecog: { code: @ecog.code, name: @ecog.name } }
    assert_redirected_to ecog_url(@ecog)
  end

  test "should destroy ecog" do
    assert_difference("Ecog.count", -1) do
      delete ecog_url(@ecog)
    end

    assert_redirected_to ecogs_url
  end
end
