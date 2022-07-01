class Milkman < ApplicationRecord
    validates :name, uniqueness: true

    has_many :milkman_products
    has_many :milkman_customers
end
