Rails.application.routes.draw do
  namespace :admin do
    root to: "books#index", as: :root
    resources :books
    resources :users
    resources :authors
    resources :publishers
  end

  root "static_pages#show", act: "home"
  get "/pages/:act" => "static_pages#show"

  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users, except: :destroy do
    resources :follow_users, only: [:create, :destroy]
  end
  resources :books, only: [:show] do
    resources :comments, only: [:create]
    resources :like_books, only: [:create, :destroy]
  end
  resources :authors, only: [:show] do
    resources :follow_authors, only: [:create, :destroy]
  end
  resources :categories, only: [:show]
end
