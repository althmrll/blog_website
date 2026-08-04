Rails.application.routes.draw do
  root "posts#index"

  resources :posts do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end

  # Custom Login & Logout routes
  get    "/login",  to: "sessions#new"
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end