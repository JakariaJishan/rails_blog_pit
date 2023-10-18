class CommentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
  end

  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:notice]="Comment Created successfully"
      redirect_to post_path(@post)
    else
      flash[:alert] ="Failed to create comment"
      redirect_to post_path(@post), status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:notice]="Comment updated successfully"
      redirect_to post_path(@post)
    else
      flash[:alert]="Failed to update comment"
      render :edit
    end

  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:notice]="Comment deleted successfully"
      redirect_to post_path(@post)

    else
      redirect_to post_path(@post), status: :unprocessable_entity
    end
  end
  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
