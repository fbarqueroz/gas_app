Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: "dashboard#index", as: :authenticated_root
  end

  devise_scope :user do
    root to: "devise/sessions#new"
  end

  get "dashboard", to: "dashboard#index"

  resources :stations do
    resources :islands, shallow: true do
      resources :service_points, shallow: true
    end
  end

  resources :products

  resources :shifts, only: [:index, :show, :new, :create] do
    member do
      patch :close
    end
    resources :sales, shallow: true, only: [:create]
  end

  resources :cash_registers, only: [:index, :show]

  get "up" => "rails/health#show", as: :rails_health_check
end
