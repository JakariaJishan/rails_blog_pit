class CommentsController < ApplicationController
  def index
  end

  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  def create
    @user = User.find(1)
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)

    @comment.user = @user
    @comment.post = @post

    if @comment.save
      redirect_to post_path(@post)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
