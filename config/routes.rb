Rails.application.routes.draw do
  resources :orders
  resources :line_items
  resources :carts
  resources :products do
    member do
      get 'who_bought'
    end
  end
  root 'store#index', as: 'store_index'
end
