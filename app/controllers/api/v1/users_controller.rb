class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  
  def index
    render json: { users: User.all, status: 200 }
  end

  def show
    render json: { user: @user, status: 200 }
  end

  def create
    @user = User.create(user_params)
    
    if @user.save
      render json: { message: "User created successfully", user: @user, status: 200 }
    else
      render json: {
        message: "Unable to create user '#{@user.name}', please try again",
        errors: @user.errors.full_messages,
        status: 422
      }, status: :unprocessable_entity
    end
  end

  def update
    @user.update(user_params)
    render json: { message: "User updated successfully", status: 200 }
  end

  def destroy
    @user.destroy
    render json: { message: "User deleted successfully", status: 200 }
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation, :role)  
  end
end
