Rails.application.routes.draw do
  get 'admin' => 'admin#index'
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
  resources :users
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
