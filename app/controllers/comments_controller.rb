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
    end
  end

  def new_reply
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:parent_id]).replies.new
    # @reply = @comment.replies.new
  end

  def create_reply
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:parent_id])
    @reply  = @comment.replies.new(comment_params)
    @reply.user_id = current_user.id
    @reply.post_id = @post.id

    if @reply.save
      redirect_to post_path(@post)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit_reply
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:parent_id])
    @reply = @comment.replies.find(params[:id])
  end

  def update_reply
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:parent_id])
    @reply = @comment.replies.find(params[:id])
    if @reply.update(comment_params)
      redirect_to post_path(@post)
    end
  end

  def destroy_reply
    @post = Post.find(params[:post_id])
    @reply = Comment.find(params[:parent_id]).replies.find(params[:id])
    if @reply.destroy
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
