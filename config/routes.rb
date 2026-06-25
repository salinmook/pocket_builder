Rails.application.routes.draw do
  get "dashboard/index"
  get "carts/show"
  get "pages/home"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  root "pages#home"
  resources :orders, only: [:index, :show] do
    member do
      patch :cancel
    end
  end
  resources :stores do
    member do
      delete :remove_logo 
      delete :remove_banner
    end
    
    resources :categories
    resources :products do
      member do
        delete :remove_image
      end
      resources :orders, only: [:create]
    end
  end
  get "/stores/:store_id/dashboard", 
  to: "dashboard#index",
  as: :store_dashboard
  resources :cart_items do 
    member do
      patch :increase
      patch :decrease
    end
  end
  resources :carts, only: [:show]
  post "/checkout", to: "orders#checkout"
  get "store/:store_id/order_success",
  to: "orders#success", 
  as: :order_success


  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
