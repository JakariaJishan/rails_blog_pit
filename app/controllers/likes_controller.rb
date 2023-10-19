class LikesController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!, only: [:create, :destroy]
  load_and_authorize_resource

  def create
      @post = Post.find(like_params[:post_id])
      @like = @post.likes.new(user_id:current_user.id)
      if @like.save
        render json: {like_count: @post.likes.count }, status:  :ok
      end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = @post.likes.find(params[:id])
    if @like.destroy
      render json: {like_count: @post.likes.count } , status: :ok
    end
  end
end

private

# def like_already_exists?
#   Like.where(user_id: current_user.id, post_id: like_params[:post_id]).exists?
# end

def like_params
  params.require(:like).permit(:post_id)
end