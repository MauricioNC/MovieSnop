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
end
