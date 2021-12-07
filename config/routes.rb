Rails.application.routes.draw do
  get 'posts/index'
  get 'posts/create'
  get 'users/create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'posts#index'

  resources :posts
  devise_for :users

  post 'access' => 'users#access', as: :create_session
  get 'share' => 'posts#new', as: :share_movie
end
