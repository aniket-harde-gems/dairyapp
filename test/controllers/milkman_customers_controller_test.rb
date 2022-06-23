require 'test_helper'

class MilkmanCustomersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @milkman_customer = milkman_customers(:one)
  end

  test "should get index" do
    get milkman_customers_url
    assert_response :success
  end

  test "should get new" do
    get new_milkman_customer_url
    assert_response :success
  end

  test "should create milkman_customer" do
    assert_difference('MilkmanCustomer.count') do
      post milkman_customers_url, params: { milkman_customer: { customer_address: @milkman_customer.customer_address, customer_mobile_number: @milkman_customer.customer_mobile_number, customer_name: @milkman_customer.customer_name, milkman_id: @milkman_customer.milkman_id } }
    end

    assert_redirected_to milkman_customer_url(MilkmanCustomer.last)
  end

  test "should show milkman_customer" do
    get milkman_customer_url(@milkman_customer)
    assert_response :success
  end

  test "should get edit" do
    get edit_milkman_customer_url(@milkman_customer)
    assert_response :success
  end

  test "should update milkman_customer" do
    patch milkman_customer_url(@milkman_customer), params: { milkman_customer: { customer_address: @milkman_customer.customer_address, customer_mobile_number: @milkman_customer.customer_mobile_number, customer_name: @milkman_customer.customer_name, milkman_id: @milkman_customer.milkman_id } }
    assert_redirected_to milkman_customer_url(@milkman_customer)
  end

  test "should destroy milkman_customer" do
    assert_difference('MilkmanCustomer.count', -1) do
      delete milkman_customer_url(@milkman_customer)
    end

    assert_redirected_to milkman_customers_url
  end
end
