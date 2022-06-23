class CreateMilkmanCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :milkman_customers do |t|
      t.string :customer_name
      t.string :customer_address
      t.integer :customer_mobile_number
      t.references :milkman, null: false, foreign_key: true

      t.timestamps
    end
  end
end
