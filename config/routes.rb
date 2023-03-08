Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "urls#new"
  resources :urls, path: "shortened_urls", only: [:new, :create, :show] do
    get "/redirect", to: "urls#redirect"
    get "/dashboard", to: "urls#dashboard"
  end
end
