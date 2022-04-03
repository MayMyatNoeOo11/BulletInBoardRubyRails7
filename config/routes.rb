Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'sessions#new'
  	
  # sign up page with form:
  get 'users/new' => 'users#new', as: :new_user

  # create (post) action for when sign up form is submitted:

  # resources :posts do
  #   collection do
  #     get :confirm_create, to: "posts#new"
  #     post :confirm_create
  #   end
  #   member do
  #     get :confirm_update, to: "posts#confirm_update"
  #     post :confirm_update
  #     post :update_post
  #   end
  # end


  # , only: [:index, :create, :update, :edit, :destroy]
  # get '/users' => 'users#index'
  #  get '/users/:id', to: 'users#profile'
  # log in page with form:
  get '/login'     => 'sessions#new'
  get '/register'     => 'users#register'
  post '/posts/import' => 'posts#import'

  post '/posts/confirm' => 'posts#confirm'
  
  post '/users/confirm' => 'users#confirm'
  post '/posts/confirm_update' => 'posts#confirm_update'
  post '/users/confirm_update' => 'users#confirm_update'

get 'users/confirmEmail'
post 'users/forgetPassword'

get 'users/changePassword', to: 'users#changePassword'

  # create (post) action for when log in form is submitted:
  post '/login'    => 'sessions#create'
  
  # delete action to log out:
  get '/logout' => 'sessions#destroy' 
  resources :posts
  resources :users
end
