Rails.application.routes.draw do
  root 'songs#search'
  
  get 'admin', to: 'access#menu'
  get 'songs', to: 'songs#search'
  get 'songs/search'
  get 'access/menu'
  get 'access/login'
  get 'access/logout'
  get 'access/select_sound_device'
  post 'access/select_sound_device'

  post 'access/attempt_login'
  post 'songs/search'

  resources :songs
  resources :branches, only: [:create, :destroy]
end
