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

  root "posts#index"

  resources :posts do
    resource :saved_post, only: [:index, :create, :destroy]

    resources :comments do 
      resources :replies
    end
    resources :likes , only: [:create, :destroy]
  end

  get '/posts/liked_users/:post_id', to: "likes#liked_users"
  get '/users/:id', to:'users#show'
  get '/users', to:'users#index'

  resources :messages, only:[:create]
  resources :questions do
    resources :answers, only: [:create, :destroy]
  end

  post '/questions/:question_id/like', to: 'likes#like_question', as: 'like_question'
  delete '/questions/:question_id/like', to: 'likes#unlike_question', as: 'unlike_question'

  post '/questions/:question_id/answers/:answer_id/like', to: 'likes#like_answer', as: 'like_answer'
  delete '/questions/:question_id/answers/:answer_id/like', to: 'likes#unlike_answer', as: 'unlike_answer'

  get '/saved_posts', to: 'saved_posts#index'
end
