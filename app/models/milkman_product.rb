class MilkmanProduct < ApplicationRecord
  validates_presence_of :product_name, :product_price

  belongs_to :milkman
  has_many :milkman_customer_products
  has_many :customer_delivery_preferences
end
