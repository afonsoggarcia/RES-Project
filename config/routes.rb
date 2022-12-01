Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "about", to: "pages#about"
  get "features", to: "pages#features"
  get "dashboard", to: "pages#dashboard"
  get 'content', to: "pages#content"
  resources :articles
  resources :topics do
    resources :replies, only: [:new, :create]
  end
  resources :replies, only: [:destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
