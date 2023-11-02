require 'sidekiq/web'

Rails.application.routes.draw do
  get 'messages/create'
  get 'chats/create'
  mount Sidekiq::Web => '/sidekiq'
  mount ActionCable.server => '/cable'
  devise_for :users, controllers: {registrations: "registrations"}
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
 end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"
  resources :posts do
    resources :comments do 
      resources :replies
    end
    resources :likes , only: [:create, :destroy]
    # get "comments/:parent_id/new", to:'comments#new_reply'
    # post "comments/:parent_id", to:'comments#create_reply'
    # get "comments/:parent_id/replies/:id/edit", to:'comments#edit_reply'
    # patch "comments/:parent_id/replies/:id", to:'comments#update_reply'
    # delete "comments/:parent_id/replies/:id", to:'comments#destroy_reply'
  end
  get '/posts/liked_users/:post_id', to: "likes#liked_users"
  get '/users/:id', to:'users#show'
  get '/users', to:'users#index'
  resources :messages, only:[:create]


end
