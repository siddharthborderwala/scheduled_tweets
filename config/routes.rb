Rails.application.routes.draw do
  get "about", to: "about#index", as: :about
  
  get "password", to: "passwords#edit", as: "edit_password"
  patch "password", to: "passwords#update"

  get "password/forgot", to: "password_resets#new"
  post "password/reset", to: "password_resets#create"
  get "password/reset", to: "password_resets#edit"
  patch "password/reset", to: "password_resets#update"

  get "signup", to: "registrations#new"
  post "signup", to: "registrations#create"

  get "signin", to: "sessions#new"
  post "signin", to: "sessions#create"

  delete "signout", to: "sessions#destroy"

  post '/auth/twitter/callback', to: "omniauth_callbacks#twitter"

  resources :twitter_accounts
  resources :tweets

  root to: "main#index"
end
