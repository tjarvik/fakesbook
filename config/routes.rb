Rails.application.routes.draw do
  
  root to: "posts#index"
  resources :posts
  devise_for :users
  resources :users
  get '/signup', to: 'sessions#new'
  get '/notifications', to: 'users#notify'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end
