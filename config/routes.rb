Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      resources :movies
    
      post 'auth/login', to: 'authentication#login'
    
      get '/users/:user_id/movies', to: "movies#get_all"
      get '/users/:user_id/movies/:movie_id', to: "movies#show_by_user"
    end
  end  
end
