require "test_helper"

class FigosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @figo = figos(:one)
  end

  test "should get index" do
    get figos_url
    assert_response :success
  end

  test "should get new" do
    get new_figo_url
    assert_response :success
  end

  test "should create figo" do
    assert_difference("Figo.count") do
      post figos_url, params: { figo: { code: @figo.code, name: @figo.name } }
    end

    assert_redirected_to figo_url(Figo.last)
  end

  test "should show figo" do
    get figo_url(@figo)
    assert_response :success
  end

  test "should get edit" do
    get edit_figo_url(@figo)
    assert_response :success
  end

  test "should update figo" do
    patch figo_url(@figo), params: { figo: { code: @figo.code, name: @figo.name } }
    assert_redirected_to figo_url(@figo)
  end

  test "should destroy figo" do
    assert_difference("Figo.count", -1) do
      delete figo_url(@figo)
    end

    assert_redirected_to figos_url
  end
end
