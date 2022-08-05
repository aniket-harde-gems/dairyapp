class CreateCustomerDeliveryRecurrings < ActiveRecord::Migration[6.0]
  def change
    create_table :customer_delivery_recurrings do |t|
      t.integer :customer_deliver_preference_id
      t.integer :recurring_type
      t.integer :day_of_week
      t.integer :seperation_count

      t.timestamps
    end
  end
end
