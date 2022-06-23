require "application_system_test_case"

class MilkmanProductsTest < ApplicationSystemTestCase
  setup do
    @milkman_product = milkman_products(:one)
  end

  test "visiting the index" do
    visit milkman_products_url
    assert_selector "h1", text: "Milkman Products"
  end

  test "creating a Milkman product" do
    visit milkman_products_url
    click_on "New Milkman Product"

    fill_in "Milkman", with: @milkman_product.milkman_id
    fill_in "Product name", with: @milkman_product.product_name
    fill_in "Product price", with: @milkman_product.product_price
    click_on "Create Milkman product"

    assert_text "Milkman product was successfully created"
    click_on "Back"
  end

  test "updating a Milkman product" do
    visit milkman_products_url
    click_on "Edit", match: :first

    fill_in "Milkman", with: @milkman_product.milkman_id
    fill_in "Product name", with: @milkman_product.product_name
    fill_in "Product price", with: @milkman_product.product_price
    click_on "Update Milkman product"

    assert_text "Milkman product was successfully updated"
    click_on "Back"
  end

  test "destroying a Milkman product" do
    visit milkman_products_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Milkman product was successfully destroyed"
  end
end
