Rails.application.routes.draw do
  resources :milkman_customers
  resources :milkman_products
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :milkmen

  root to: 'milkmen#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
