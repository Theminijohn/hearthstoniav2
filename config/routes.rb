Hearthstoniav2::Application.routes.draw do


  mount RedactorRails::Engine => '/redactor_rails'
  resources :tags

  root 'questions#index'

  devise_for :users

  get 'users/:id' => 'users#show', as: :user

  resources :questions do
    resources :answers do
      member do
        get :upvote
        get :downvote
      end
    end
    member do
      get :upvote
      get :downvote
    end
  end

  get "users/show"
  get 'about' => 'pages#about'
end
