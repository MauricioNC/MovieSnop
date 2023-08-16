class Api::V1::MoviesController < ApplicationController
  before_action :set_user, only: %i[ index show create update destroy ]
  before_action :set_movie, only: %i[ show update destroy ]

  def get_all
    @response = []
    
    User.all.each do |u|
      @response.push({ user_id: u.id, movies: u.movies })
    end

    render json: { data: @response, status: 200 }
  end

  def index
    render json: { movies: @user.movies.all, status: 200 }
  end

  def show
    render json: { movie: @movie, status: 200 }
  end

  def create
    @movie = @user.movies.build(movie_params)
    
    if @movie.save
      render json: {
        message: "The movie '#{@movie.title}' was registered successfully",
        movie: @movie,
        status: 200
      }
    else
      render json: {
        message: "Someting went wrong registering movie '#{@movie.title}'",
        errors: @movie.errors.full_messages,
        status: 422
      }, status: :unprocessable_entity
    end
  end

  def update
    @movie.update(movie_params)
    render json: { message: "The movie '#{@movie.title}' was updated successfully", status: 200 }
  end

  def destroy
    @movie.destroy
    render json: { message: "Movie deleted successfully", status: 200 }
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :duration, :thriller_link, :public_date, :director_id)
  end
end
