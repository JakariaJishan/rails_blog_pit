class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users= User.all
  end

  def show
      @users = User.all
      @user = User.find(params[:id])
      @messages = Message.where(sender_id: current_user.id, recipient_id: @user.id)
                         .or(Message.where(sender_id: @user.id, recipient_id: current_user.id))


  end
  def new
  end

  def create
  end


end
