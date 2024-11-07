require "test_helper"

class PostneoStagingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @postneo_staging = postneo_stagings(:one)
  end

  test "should get index" do
    get postneo_stagings_url
    assert_response :success
  end

  test "should get new" do
    get new_postneo_staging_url
    assert_response :success
  end

  test "should create postneo_staging" do
    assert_difference("PostneoStaging.count") do
      post postneo_stagings_url, params: { postneo_staging: { code: @postneo_staging.code, name: @postneo_staging.name } }
    end

    assert_redirected_to postneo_staging_url(PostneoStaging.last)
  end

  test "should show postneo_staging" do
    get postneo_staging_url(@postneo_staging)
    assert_response :success
  end

  test "should get edit" do
    get edit_postneo_staging_url(@postneo_staging)
    assert_response :success
  end

  test "should update postneo_staging" do
    patch postneo_staging_url(@postneo_staging), params: { postneo_staging: { code: @postneo_staging.code, name: @postneo_staging.name } }
    assert_redirected_to postneo_staging_url(@postneo_staging)
  end

  test "should destroy postneo_staging" do
    assert_difference("PostneoStaging.count", -1) do
      delete postneo_staging_url(@postneo_staging)
    end

    assert_redirected_to postneo_stagings_url
  end
end
