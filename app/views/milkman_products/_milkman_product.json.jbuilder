json.extract! milkman_product, :id, :product_name, :product_price, :milkman_id, :created_at, :updated_at
json.url milkman_product_url(milkman_product, format: :json)
