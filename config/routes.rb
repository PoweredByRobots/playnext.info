Rails.application.routes.draw do
  get 'admin', to: 'access#menu'
  get 'access/menu'
  get 'access/login'
  get 'access/logout'
  post 'access/attempt_login'

  resources :songs
  resources :branches, only: [:create, :destroy]
end
