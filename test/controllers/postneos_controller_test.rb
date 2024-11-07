require "test_helper"

class PostneosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @postneo = postneos(:one)
  end

  test "should get index" do
    get postneos_url
    assert_response :success
  end

  test "should get new" do
    get new_postneo_url
    assert_response :success
  end

  test "should create postneo" do
    assert_difference("Postneo.count") do
      post postneos_url, params: { postneo: { code: @postneo.code, name: @postneo.name } }
    end

    assert_redirected_to postneo_url(Postneo.last)
  end

  test "should show postneo" do
    get postneo_url(@postneo)
    assert_response :success
  end

  test "should get edit" do
    get edit_postneo_url(@postneo)
    assert_response :success
  end

  test "should update postneo" do
    patch postneo_url(@postneo), params: { postneo: { code: @postneo.code, name: @postneo.name } }
    assert_redirected_to postneo_url(@postneo)
  end

  test "should destroy postneo" do
    assert_difference("Postneo.count", -1) do
      delete postneo_url(@postneo)
    end

    assert_redirected_to postneos_url
  end
end
