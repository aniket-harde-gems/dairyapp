require 'test_helper'

class MilkmanProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @milkman_product = milkman_products(:one)
  end

  test "should get index" do
    get milkman_products_url
    assert_response :success
  end

  test "should get new" do
    get new_milkman_product_url
    assert_response :success
  end

  test "should create milkman_product" do
    assert_difference('MilkmanProduct.count') do
      post milkman_products_url, params: { milkman_product: { milkman_id: @milkman_product.milkman_id, product_name: @milkman_product.product_name, product_price: @milkman_product.product_price } }
    end

    assert_redirected_to milkman_product_url(MilkmanProduct.last)
  end

  test "should show milkman_product" do
    get milkman_product_url(@milkman_product)
    assert_response :success
  end

  test "should get edit" do
    get edit_milkman_product_url(@milkman_product)
    assert_response :success
  end

  test "should update milkman_product" do
    patch milkman_product_url(@milkman_product), params: { milkman_product: { milkman_id: @milkman_product.milkman_id, product_name: @milkman_product.product_name, product_price: @milkman_product.product_price } }
    assert_redirected_to milkman_product_url(@milkman_product)
  end

  test "should destroy milkman_product" do
    assert_difference('MilkmanProduct.count', -1) do
      delete milkman_product_url(@milkman_product)
    end

    assert_redirected_to milkman_products_url
  end
end
