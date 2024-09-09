require "test_helper"

class CancerFormStatusesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cancer_form_status = cancer_form_statuses(:one)
  end

  test "should get index" do
    get cancer_form_statuses_url, as: :json
    assert_response :success
  end

  test "should create cancer_form_status" do
    assert_difference("CancerFormStatus.count") do
      post cancer_form_statuses_url, params: { cancer_form_status: { name: @cancer_form_status.name } }, as: :json
    end

    assert_response :created
  end

  test "should show cancer_form_status" do
    get cancer_form_status_url(@cancer_form_status), as: :json
    assert_response :success
  end

  test "should update cancer_form_status" do
    patch cancer_form_status_url(@cancer_form_status), params: { cancer_form_status: { name: @cancer_form_status.name } }, as: :json
    assert_response :success
  end

  test "should destroy cancer_form_status" do
    assert_difference("CancerFormStatus.count", -1) do
      delete cancer_form_status_url(@cancer_form_status), as: :json
    end

    assert_response :no_content
  end
end
