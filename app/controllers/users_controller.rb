class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    friend_ids = current_user.friends.pluck(:id)
    friend_ids << current_user.id
    @users = User.where(id: friend_ids).order(online: :desc)
  end

  def show
      friend_ids = current_user.friends.pluck(:id)
      friend_ids << current_user.id
      @users = User.where(id: friend_ids).order(online: :desc)
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
    @posts = @user.posts.order(created_at: :desc)
  end

  def friends
    @user =  current_user || User.find(params[:user_id])

    # Fetch friends and statuses
    @pending_sent_requests = @user.pending_sent_requests
    @pending_received_requests = @user.pending_received_requests
    @accepted_friends = @user.friends
    @not_friends = @user.non_friends
  end

  def new_password
    @user = current_user
  end
  def change_password
    @user = current_user
    current_password = params[:user][:current_password]
    new_password = params[:user][:password]
    new_password_confirmation = params[:user][:password_confirmation]

    # Check if new password and confirmation match
    unless new_password == new_password_confirmation
      flash[:alert] = "Passwords do not match."
      return render :new_password
    end

    # Validate current password
    unless @user.valid_password?(current_password)
      flash[:alert] = "Current password is incorrect."
      return render :new_password
    end

    # Update user's password and save
    @user.password = new_password
    if @user.save
      sign_in(@user, bypass: true)
      flash[:notice] = "Password changed successfully!"
      redirect_to root_path
    else
      flash[:alert] = "Unable to change password."
      render :new_password
    end
  end


end
