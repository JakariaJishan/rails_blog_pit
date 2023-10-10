Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
    post '/registrations/save_data_url', to: 'registrations#save_data_url'
 end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"
  resources :posts do
    resources :comments do 
      resources :replies
    end
    # get "comments/:parent_id/new", to:'comments#new_reply'
    # post "comments/:parent_id", to:'comments#create_reply'
    # get "comments/:parent_id/replies/:id/edit", to:'comments#edit_reply'
    # patch "comments/:parent_id/replies/:id", to:'comments#update_reply'
    # delete "comments/:parent_id/replies/:id", to:'comments#destroy_reply'
  end

end
