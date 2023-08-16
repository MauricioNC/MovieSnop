class ApplicationController < ActionController::API
  include JwtToken
  include ActionController::MimeResponds

  before_action :authenticate

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

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
    @user ||= User.find(params[:user_id])
  end

  def set_movie
    @movie ||= @user.movies.find(params[:id])
  end

  # Errors

  def not_found
    render json: { error: "Record not found", status: 422 }, status: :unprocessable_entity
  end
end
