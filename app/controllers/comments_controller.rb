class CommentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
  end

  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  def create
    @user = current_user
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

  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])

  end

  def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to post_path(@post)
    end

  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to post_path(@post)
    else
      redirect_to post_path(@post), status: :unprocessable_entity
    end  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
