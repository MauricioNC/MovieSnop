class MoviesController < ApplicationController
  before_action :set_user, only: [ :create ]
  before_action :set_movie, only: [ :show, :update, :destroy ]

  def index
    respond_to do |format|
      format.json do
        render json: { movies: Movie.all, status: 200 }
      end
    end
  end

  def show
    respond_to do |format|
      format.json do
        render json: { movie: @movie, status: 200 }
      end
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
end
