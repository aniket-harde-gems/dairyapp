require "application_system_test_case"

class MilkmanCustomersTest < ApplicationSystemTestCase
  setup do
    @milkman_customer = milkman_customers(:one)
  end

  test "visiting the index" do
    visit milkman_customers_url
    assert_selector "h1", text: "Milkman Customers"
  end

  test "creating a Milkman customer" do
    visit milkman_customers_url
    click_on "New Milkman Customer"

    fill_in "Customer address", with: @milkman_customer.customer_address
    fill_in "Customer mobile number", with: @milkman_customer.customer_mobile_number
    fill_in "Customer name", with: @milkman_customer.customer_name
    fill_in "Milkman", with: @milkman_customer.milkman_id
    click_on "Create Milkman customer"

    assert_text "Milkman customer was successfully created"
    click_on "Back"
  end

  test "updating a Milkman customer" do
    visit milkman_customers_url
    click_on "Edit", match: :first

    fill_in "Customer address", with: @milkman_customer.customer_address
    fill_in "Customer mobile number", with: @milkman_customer.customer_mobile_number
    fill_in "Customer name", with: @milkman_customer.customer_name
    fill_in "Milkman", with: @milkman_customer.milkman_id
    click_on "Update Milkman customer"

    assert_text "Milkman customer was successfully updated"
    click_on "Back"
  end

  test "destroying a Milkman customer" do
    visit milkman_customers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Milkman customer was successfully destroyed"
  end
end
