require "test_helper"

class SearchIcdosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @search_icdo = search_icdos(:one)
  end

  test "should get index" do
    get search_icdos_url, as: :json
    assert_response :success
  end

  test "should create search_icdo" do
    assert_difference("SearchIcdo.count") do
      post search_icdos_url, params: { search_icdo: { diagnose_paragraph_id: @search_icdo.diagnose_paragraph_id, icdo_id: @search_icdo.icdo_id } }, as: :json
    end

    assert_response :created
  end

  test "should show search_icdo" do
    get search_icdo_url(@search_icdo), as: :json
    assert_response :success
  end

  test "should update search_icdo" do
    patch search_icdo_url(@search_icdo), params: { search_icdo: { diagnose_paragraph_id: @search_icdo.diagnose_paragraph_id, icdo_id: @search_icdo.icdo_id } }, as: :json
    assert_response :success
  end

  test "should destroy search_icdo" do
    assert_difference("SearchIcdo.count", -1) do
      delete search_icdo_url(@search_icdo), as: :json
    end

    assert_response :no_content
  end
end
