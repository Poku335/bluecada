require "test_helper"

class DiagnoseInformationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @diagnose_information = diagnose_informations(:one)
  end

  test "should get index" do
    get diagnose_informations_url, as: :json
    assert_response :success
  end

  test "should create diagnose_information" do
    assert_difference("DiagnoseInformation.count") do
      post diagnose_informations_url, params: { diagnose_information: { cancer_information_id: @diagnose_information.cancer_information_id, diag_date: @diagnose_information.diag_date, diagnose_paragraph: @diagnose_information.diagnose_paragraph } }, as: :json
    end

    assert_response :created
  end

  test "should show diagnose_information" do
    get diagnose_information_url(@diagnose_information), as: :json
    assert_response :success
  end

  test "should update diagnose_information" do
    patch diagnose_information_url(@diagnose_information), params: { diagnose_information: { cancer_information_id: @diagnose_information.cancer_information_id, diag_date: @diagnose_information.diag_date, diagnose_paragraph: @diagnose_information.diagnose_paragraph } }, as: :json
    assert_response :success
  end

  test "should destroy diagnose_information" do
    assert_difference("DiagnoseInformation.count", -1) do
      delete diagnose_information_url(@diagnose_information), as: :json
    end

    assert_response :no_content
  end
end
