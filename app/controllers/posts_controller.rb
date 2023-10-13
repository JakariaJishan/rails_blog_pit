class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  load_and_authorize_resource
  helper_method :time_ago
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
      render :new, status: :unprocessable_entity
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

  def time_ago (date)
    current_date = Time.zone.now
    target_date = date
    time_diff = (current_date - target_date).to_i
    seconds = time_diff.to_i
    minutes = (time_diff / 60).to_i
    hours = (time_diff / 3600).to_i
    days = (time_diff / (3600 * 24)).to_i
    months = (time_diff / (3600 * 24 * 30)).to_i
    years = (time_diff / (3600 * 24 * 365)).to_i

    if seconds < 60
       "a few seconds ago"
    elsif minutes == 1
      return "1 minute ago"
    elsif minutes < 60
      return "#{minutes} minutes ago"
    elsif hours == 1
      return "1 hour ago"
    elsif hours < 24
      return "#{hours} hours ago"
    elsif days == 1
      return "1 day ago"
    elsif days < 30
      return "#{days} days ago"
    elsif months == 1
      return "1 month ago"
    elsif months < 12
      return "#{months} months ago"
    elsif years == 1
      return "1 year ago"
    else
       "#{years} years ago"
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :post_image)
  end
end
