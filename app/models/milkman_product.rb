class MilkmanProduct < ApplicationRecord
  belongs_to :milkman
  has_many :milkman_customer_products
end
