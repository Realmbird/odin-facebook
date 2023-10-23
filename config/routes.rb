Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users
  resources :friendships
  resources :posts
  
  patch '/friendships', to: 'friendships#update'
  # Defines the root path route ("/")
  # root "articles#index"
  root "users#index"
end
