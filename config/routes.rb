Rails.application.routes.draw do
  # GET /about
  get "about-us", to: "about#index", as: :about

  # GET /
  root to: "main#index"
end
