class CustomerDeliveryPreference < ApplicationRecord
  validates_presence_of :milkman_product_id, :shift, :quantity

  belongs_to :milkman_customer
  belongs_to :milkman_product
end
