Rails.application.routes.draw do
  resources :users
  resources :movies

  post 'auth/login', to: 'authentication#login'
end
