class ChangeCustomerMobileNumberToBeStringInMilkmanCustomers < ActiveRecord::Migration[6.0]
  def change
    change_column :milkman_customers, :customer_mobile_number, :string
  end
end
