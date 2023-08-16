class ApplicationController < ActionController::API
  include JwtToken
  include ActionController::MimeResponds

  before_action :authenticate

  private

  def authenticate
    header = request.headers['Authorization']
    header = header.split(' ').last if header

    begin
      @decoded = jwt_decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message, status: :unauthorized }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message, status: :unauthorized }, status: :unauthorized
    end
  end

  def set_user
    begin
      @user ||= User.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message, status: 422 }, status: :unprocessable_entity
    end
  end

  def set_movie
    begin
      @movie ||= @current_user.movies.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message, status: 422 }, status: :unprocessable_entity
    end
  end
end
