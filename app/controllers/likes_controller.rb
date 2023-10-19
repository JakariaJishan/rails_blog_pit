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
end

private

def like_params
  params.require(:like).permit(:post_id)
end