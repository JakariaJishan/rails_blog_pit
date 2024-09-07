class FriendshipsController < ApplicationController
  before_action :find_user, only: [:create, :accept, :decline, :unfriend]

  # Send a friend request
  def create
    @friendship = Friendship.new(sender: current_user, receiver: @user, status: 'pending')

    if @friendship.save
      flash[:notice] = "Friend request sent!"
    else
      flash[:alert] = "Unable to send friend request."
    end

    redirect_back(fallback_location: root_path)
  end

  # Accept a friend request
  def accept
    @friendship = Friendship.find_by(sender: @user, receiver: current_user, status: 'pending')

    if @friendship.update(status: 'accepted')
      flash[:notice] = "Friend request accepted!"
    else
      flash[:alert] = "Unable to accept friend request."
    end

    redirect_back(fallback_location: root_path)
  end

  # Decline a friend request
  def decline
    @friendship = Friendship.find_by(sender: @user, receiver: current_user, status: 'pending')
    @sent_friendship = Friendship.find_by(sender: current_user, receiver: @user, status: 'pending')

    if @friendship && @friendship.destroy
      flash[:notice] = "Friend request declined!"
    end

    if @sent_friendship && @sent_friendship.destroy
      flash[:notice] = "Friend request declined!"
    end

    redirect_back(fallback_location: root_path)
  end

  def unfriend
    @friendship = Friendship.find_by(sender: current_user, receiver: @user) ||
      Friendship.find_by(sender: @user, receiver: current_user)
    if @friendship
      @friendship.destroy
      flash[:notice] = "You are no longer friends with #{@user.username}."
    else
      flash[:alert] = "Friendship not found."
    end
    redirect_back(fallback_location: root_path)
  end

  def reject

  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end
end
