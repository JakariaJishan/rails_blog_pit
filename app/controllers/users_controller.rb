class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users= User.all
  end

  def show
      @users = User.all.order(online: :desc)
      @user = User.find(params[:id])
      @messages = Message.where(sender_id: current_user.id, recipient_id: @user.id)
                         .or(Message.where(sender_id: @user.id, recipient_id: current_user.id))


  end
  def new
  end

  def create
  end

  def profile
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def friends
    @user =  current_user || User.find(params[:user_id])

    # Fetch friends and statuses
    @pending_sent_requests = @user.pending_sent_requests
    @pending_received_requests = @user.pending_received_requests
    @accepted_friends = @user.friends
    @not_friends = @user.non_friends
  end


end
