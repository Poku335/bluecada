require "test_helper"

class GradsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @grad = grads(:one)
  end

  test "should get index" do
    get grads_url, as: :json
    assert_response :success
  end

  test "should create grad" do
    assert_difference("Grad.count") do
      post grads_url, params: { grad: { code: @grad.code, name: @grad.name } }, as: :json
    end

    assert_response :created
  end

  test "should show grad" do
    get grad_url(@grad), as: :json
    assert_response :success
  end

  test "should update grad" do
    patch grad_url(@grad), params: { grad: { code: @grad.code, name: @grad.name } }, as: :json
    assert_response :success
  end

  test "should destroy grad" do
    assert_difference("Grad.count", -1) do
      delete grad_url(@grad), as: :json
    end

    assert_response :no_content
  end
end
