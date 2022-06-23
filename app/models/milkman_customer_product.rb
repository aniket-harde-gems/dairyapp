class MilkmanCustomerProduct < ApplicationRecord
    belongs_to :milkman_customer
    belongs_to :milkman_product
end
