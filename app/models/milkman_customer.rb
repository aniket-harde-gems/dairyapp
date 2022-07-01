class MilkmanCustomer < ApplicationRecord
  validates :customer_name, uniqueness: true
  validates_presence_of :customer_name, :customer_address, :customer_mobile_number

  belongs_to :milkman
  has_many :milkman_customer_products
  has_many :customer_delivery_preferences
end
