class AuthenticationController < ApplicationController
  skip_before_action :authenticate

  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = jwt_encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token,  time: time.strftime("%m-%d-%Y %H:%M"), username: @user.username }
    else
      render json: { error: "Unauthorized" }, status: :unauthorirzed
    end
  end
end
