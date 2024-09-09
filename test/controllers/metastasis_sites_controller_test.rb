require "test_helper"

class MetastasisSitesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @metastasis_site = metastasis_sites(:one)
  end

  test "should get index" do
    get metastasis_sites_url, as: :json
    assert_response :success
  end

  test "should create metastasis_site" do
    assert_difference("MetastasisSite.count") do
      post metastasis_sites_url, params: { metastasis_site: { code: @metastasis_site.code, name: @metastasis_site.name } }, as: :json
    end

    assert_response :created
  end

  test "should show metastasis_site" do
    get metastasis_site_url(@metastasis_site), as: :json
    assert_response :success
  end

  test "should update metastasis_site" do
    patch metastasis_site_url(@metastasis_site), params: { metastasis_site: { code: @metastasis_site.code, name: @metastasis_site.name } }, as: :json
    assert_response :success
  end

  test "should destroy metastasis_site" do
    assert_difference("MetastasisSite.count", -1) do
      delete metastasis_site_url(@metastasis_site), as: :json
    end

    assert_response :no_content
  end
end
