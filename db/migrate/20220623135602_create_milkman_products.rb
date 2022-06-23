class CreateMilkmanProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :milkman_products do |t|
      t.string :product_name
      t.integer :product_price
      t.references :milkman, null: false, foreign_key: true

      t.timestamps
    end
  end
end
