Rails.application.routes.draw do
  root "static_pages#show", act: "home"
  get "/pages/:act" => "static_pages#show"

  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users, only: [:show, :new, :create]
end
