Rails.application.routes.draw do
  get 'milkman_customers_imports/new'
  get 'milkman_customers_imports/create'
  resources :milkman_customers
  resources :milkman_products
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :milkmen

  resources :milkman_customers_imports, only: [:new, :create]

  root to: 'milkmen#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
