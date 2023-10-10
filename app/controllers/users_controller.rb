class UsersController < ApplicationController
  def index
    @users= User.all
  end

  def new
  end

  def create
    @user = User.new(user_params)
    @user.avatar.attach(params[:user][:avatar])
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
