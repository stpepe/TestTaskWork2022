Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'posts/own/:user_id', to: "posts#own"
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  resources :posts, only: [:index, :new, :edit, :create, :update, :show, :destroy, :own] do
      resources :comments, only: [:create, :destroy, :edit, :update]
  end  

  root "mainpage#index"

end
