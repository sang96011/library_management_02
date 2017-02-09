Rails.application.routes.draw do
  namespace :admin do
    root to: "books#index", as: :root
    resources :books, only: :index
  end

  root "static_pages#show", act: "home"
  get "/pages/:act" => "static_pages#show"

  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users, except: :destroy
end
