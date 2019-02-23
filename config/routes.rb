Rails.application.routes.draw do
  root 'songs#search'
  
  get 'admin', to: 'access#menu'
  get 'songs', to: 'songs#search'
  get 'songs/search'
  get 'access/menu'
  get 'access/login'
  get 'access/logout'

  post 'access/attempt_login'

  resources :songs
  resources :branches, only: [:create, :destroy]
end
