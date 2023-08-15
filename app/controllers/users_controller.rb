class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  
  def index
    respond_to do |format|
      format.json do 
        render json: { users: User.all, status: 200 }
      end
    end
  end

  def show
    respond_to do |format|
      format.json do 
        render json: {
          user: @user, status: 200 
        }
      end
    end
  end

  def create
    @user = User.create(user_params)
    
    respond_to do |format|
      if @user.save
        format.json do 
          render json: {
            message: "User created successfully", user: @user, status: 200 
          }
        end
      else
        format.json do 
          render json: {
            message: "Unable to create user '#{@user.name}', please try again",
            errors: @user.errors.full_messages,
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
          message: "User updated successfully", status: 200
        }
      end
    end
  end

  def destroy
    respond_to do |format|
      format.json do
        render json: {
          message: "User deleted successfully", status: 200
        }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :password_digest, :password_confirmation, :role)  
  end
end
