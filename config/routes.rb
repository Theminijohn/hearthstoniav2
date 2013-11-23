Hearthstoniav2::Application.routes.draw do

  resources :tags

  root 'questions#index'

  devise_for :users

  get 'users/:id' => 'users#show', as: :user

  resources :questions

  get "users/show"
  get 'about' => 'pages#about'
end
