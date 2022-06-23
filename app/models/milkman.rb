class Milkman < ApplicationRecord
    has_many :milkman_products
    has_many :milkman_customers
end
