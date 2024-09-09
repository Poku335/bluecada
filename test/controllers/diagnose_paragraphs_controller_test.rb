require "test_helper"

class DiagnoseParagraphsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @diagnose_paragraph = diagnose_paragraphs(:one)
  end

  test "should get index" do
    get diagnose_paragraphs_url, as: :json
    assert_response :success
  end

  test "should create diagnose_paragraph" do
    assert_difference("DiagnoseParagraph.count") do
      post diagnose_paragraphs_url, params: { diagnose_paragraph: { cancer_information_id: @diagnose_paragraph.cancer_information_id, diag_date: @diagnose_paragraph.diag_date, diagnose_paragraph: @diagnose_paragraph.diagnose_paragraph } }, as: :json
    end

    assert_response :created
  end

  test "should show diagnose_paragraph" do
    get diagnose_paragraph_url(@diagnose_paragraph), as: :json
    assert_response :success
  end

  test "should update diagnose_paragraph" do
    patch diagnose_paragraph_url(@diagnose_paragraph), params: { diagnose_paragraph: { cancer_information_id: @diagnose_paragraph.cancer_information_id, diag_date: @diagnose_paragraph.diag_date, diagnose_paragraph: @diagnose_paragraph.diagnose_paragraph } }, as: :json
    assert_response :success
  end

  test "should destroy diagnose_paragraph" do
    assert_difference("DiagnoseParagraph.count", -1) do
      delete diagnose_paragraph_url(@diagnose_paragraph), as: :json
    end

    assert_response :no_content
  end
end
