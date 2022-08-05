class RenameStratingDateToStartingDateInCustomerDeliveryPreferences < ActiveRecord::Migration[6.0]
  def change
    rename_column :customer_delivery_preferences, :strating_date, :starting_date
  end
end
