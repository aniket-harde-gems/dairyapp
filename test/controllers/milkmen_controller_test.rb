require 'test_helper'

class MilkmenControllerTest < ActionDispatch::IntegrationTest
  setup do
    @milkman = milkmen(:one)
  end

  test "should get index" do
    get milkmen_url
    assert_response :success
  end

  test "should get new" do
    get new_milkman_url
    assert_response :success
  end

  test "should create milkman" do
    assert_difference('Milkman.count') do
      post milkmen_url, params: { milkman: { name: @milkman.name } }
    end

    assert_redirected_to milkman_url(Milkman.last)
  end

  test "should show milkman" do
    get milkman_url(@milkman)
    assert_response :success
  end

  test "should get edit" do
    get edit_milkman_url(@milkman)
    assert_response :success
  end

  test "should update milkman" do
    patch milkman_url(@milkman), params: { milkman: { name: @milkman.name } }
    assert_redirected_to milkman_url(@milkman)
  end

  test "should destroy milkman" do
    assert_difference('Milkman.count', -1) do
      delete milkman_url(@milkman)
    end

    assert_redirected_to milkmen_url
  end
end
