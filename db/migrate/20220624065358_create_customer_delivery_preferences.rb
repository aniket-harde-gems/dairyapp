class CreateCustomerDeliveryPreferences < ActiveRecord::Migration[6.0]
  def change
    create_table :customer_delivery_preferences do |t|
      t.integer :milkman_customer_id
      t.integer :milkman_product_id
      t.string :shift
      t.integer :quantity

      t.timestamps
    end
  end
end
