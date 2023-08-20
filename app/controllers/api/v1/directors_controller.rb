class Api::V1::DirectorsController < ApplicationController
  before_action :set_director, only: %i[ show update destroy ]

  def index
    @directors = Director.all
    render json: { directors: @directors, status: 200 }
  end

  def show
    pp @director
    render json: { director: @director, status: 200 }
  end

  def create
    @director = Director.new(director_params)

    if @director.save
      render json: { message: "Director was created successfully", status: 200 }
    else
      render json: { error: @director.errors.full_messages, status: 422 }, status: :unprocessable_entity
    end
  end

  def update
    if @director.update(director_params)
      render json: { message: "Director was updated successfully", status: 200 }
    else
      render json: { error: @director.error.full_messages, status: 422 }, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      @director.destroy
      render json: { message: "Director was deleted successfully", status: 200 }
    rescue => e
      render json: { error: e.message, status: 422 }, status: :unprocessable_entity
    end
  end

  private 

  def set_director
    @director = Director.find(params[:director_id])
  end

  def director_params
    params.require(:director).permit(:name)
  end
end
