class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  load_and_authorize_resource
  def index
    @posts = Post.includes(:user).order(created_at: :desc)
  end

  def show
    @post = Post.includes(user: :comments).find(params[:id])
    @comments = @post.comments.where(parent_id:nil).order(created_at: :desc)
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @user = current_user
    @post = Post.new(post_params)
    @post.user = @user

    if @post.save
      flash[:notice] ="Post created successfully"
      redirect_to posts_path
    else
      flash[:alert] = "Failed to create post"
      render :create, status: :unprocessable_entity
    end

  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "Post updated successfully"
      redirect_to post_path(@post)
    else
      flash[:alert] = "Failed to update post"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "Post deleted successfully"
      redirect_to posts_path
    else
      flash[:alert] = "Failed to delete post"
      redirect_to post_path(@post), status: :unprocessable_entity
    end
  end



  private

  def post_params
    params.require(:post).permit(:title, :content, :post_image)
  end
end
