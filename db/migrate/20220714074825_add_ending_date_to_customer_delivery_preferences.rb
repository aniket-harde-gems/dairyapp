class AddEndingDateToCustomerDeliveryPreferences < ActiveRecord::Migration[6.0]
  def change
    add_column :customer_delivery_preferences, :ending_date, :date
  end
end
