Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      
      scope '/users/:user_id' do
        resources :movies
      end

      get '/movies', to: "movies#get_all"

      scope '/movies/:movie_id' do
        resources :comments
      end
      
      post 'auth/login', to: 'authentication#login'
    end
  end  
end
