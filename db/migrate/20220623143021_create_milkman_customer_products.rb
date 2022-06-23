class CreateMilkmanCustomerProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :milkman_customer_products do |t|
      t.integer :milkman_customer_id
      t.integer :milkman_product_id

      t.timestamps
    end
  end
end
