Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "about", to: "pages#about"
  get "features", to: "pages#features"
  get "dashboard", to: "pages#dashboard"
  get 'content', to: "pages#content"
  get "calculator", to: "pages#calculator"
  get "distance", to: 'pages#distance'
  resources :articles do
    resources :likes
  end
  resources :topics do
    resources :replies, only: [:new, :create] do
      resources :comments, only: [:new, :create]
    end
  end
  resources :replies, only: [:destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
