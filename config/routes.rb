Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'posts#index'

  resources :posts
  devise_for :users

  post 'authen' => 'users#create', as: :create_session
  get 'share' => 'posts#new', as: :share_movie
end
