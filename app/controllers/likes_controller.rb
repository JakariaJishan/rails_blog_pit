class LikesController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!, only: [:create, :destroy]
  load_and_authorize_resource

  def create
      @post = Post.find(like_params[:post_id])
      @like = @post.likes.new(user_id:current_user.id)
      @user_like = @post.likes.find{ |like| like.user_id == current_user.id}
      if @like.save
        render json: {liked_number: @post.likes.count, like_id: @user_like.id }, status:  :ok
      end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = @post.likes.find(params[:id])
    @user_like = @post.likes.find{ |like| like.user_id == current_user.id}
    if @like.destroy
      render json: {liked_number: @post.likes.count, like_id: @user_like.id } , status: :ok
    end
  end

  def liked_users
    @post = Post.find(params[:post_id])
    @likes = @post.likes
    response = @likes.map do |like|
      user = like.user
      avatar = url_for(user.avatar)
      user_name = user.username
      {
        userName:user_name,
        avatar: avatar,
      }
    end
    # @users = @likes.map {|like| like.user}
    # @avatars = @users.map{|user| user.avatar }
    render json: {users: response}

  end
end

private

def like_params
  params.require(:like).permit(:post_id)
end