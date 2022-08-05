class RenameCustomerDeliverPreferenceIdToCustomerDeliveryPreferenceIdInCustomerDeliveryRecurrings < ActiveRecord::Migration[6.0]
  def change
    rename_column :customer_delivery_recurrings, :customer_deliver_preference_id, :customer_delivery_preference_id
  end
end
