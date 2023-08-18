Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do

      scope '/admin/:admin_id' do
        resources :users, only: %i[ index show update destroy ], param: :user_id
      end
      
      post '/users', to: "users#create"

      scope '/users/:user_id' do
        resources :movies, param: :movie_id
      end

      get '/movies', to: "movies#get_all"

      scope '/movies/:movie_id' do
        resources :comments, param: :comment_id
      end
      
      post 'auth/login', to: 'authentication#login'
    end
  end  
end
