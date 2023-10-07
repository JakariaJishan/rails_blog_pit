class RepliesController < ApplicationController
    
  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:comment_id]).replies.new
    # @reply = @comment.replies.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:comment_id])
    @reply  = @comment.replies.new(comment_params)
    @reply.user_id = current_user.id
    @reply.post_id = @post.id

    if @reply.save
      redirect_to post_path(@post)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:comment_id])
    @reply = @comment.replies.find(params[:id])
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:comment_id])
    @reply = @comment.replies.find(params[:id])
    if @reply.update(comment_params)
      redirect_to post_path(@post)
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @reply = Comment.find(params[:comment_id]).replies.find(params[:id])
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