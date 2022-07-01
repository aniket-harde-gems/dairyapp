require 'test_helper'

class MilkmanCustomersImportsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get milkman_customers_imports_new_url
    assert_response :success
  end

  test "should get create" do
    get milkman_customers_imports_create_url
    assert_response :success
  end

end
