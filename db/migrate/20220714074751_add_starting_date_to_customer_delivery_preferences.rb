class AddStartingDateToCustomerDeliveryPreferences < ActiveRecord::Migration[6.0]
  def change
    add_column :customer_delivery_preferences, :strating_date, :date
  end
end
