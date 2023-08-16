class MoviesController < ApplicationController
  before_action :set_user, only: [ :create ]
  before_action :set_error, only: [ :index, :show_by_user ]
  before_action :set_movie, only: [ :show, :update, :destroy ]

  def get_all
    begin
      validate_user_query
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message, status: 422 }, status: :unprocessable_entity
      return
    end

    render json: {
      username: @user_query.username,
      movies: @user_query.movies,
      status: 200
    }
  end

  def index
    render json: { movies: @current_user.movies.all, status: 200 }
  end

  def show
    respond_to do |format|
      format.json do
        render json: { movie: @movie, status: 200 }
      end
    end
  end

  def show_by_user
    begin
      validate_user_query
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message, status: 422 }, status: :unprocessable_entity
      return
    end

    begin
      render json: {
        username: @user_query.username,
        movies: @user_query.movies.find(params[:movie_id]),
        status: 200
      }
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message, status: 422 }, status: :unprocessable_entity
    end

  end

  def create
    @movie = @user.movies.build(movie_params)
    respond_to do |format|
      if @movie.save
        format.json do
          render json: {
            message: "The movie '#{@movie.title}' was registered successfully",
            movie: @movie,
            status: 200
          }
        end
      else
        format.json do
          render json: {
            message: "Someting went wrong registering movie '#{@movie.title}'",
            errors: @movie.errors.full_messages,
            status: 422
          }, status: :unprocessable_entity
        end
      end
    end
  end

  def update
    respond_to do |format|
      format.json do
        render json: {
          message: "The movie '#{@movie.title}' was updated successfully",
          status: 200
        }
      end
    end
  end

  def destroy
    respond_to do |format|
      format.json do
        render json: {
          message: "Movie deleted successfully",
          status: 200
        }
      end
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :duration, :thriller_link, :public_date, :director_id)
  end

  def set_error
    @error = nil
  end

  def validate_user_query
    @user_query = User.find(params[:user_id])
  end
end
