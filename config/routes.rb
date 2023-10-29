Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, :posts, :friendships, :likes, :comments
  
  
  patch '/friendships', to: 'friendships#update'
  # Defines the root path route ("/")
  # root "articles#index"
  root "users#index"
end
