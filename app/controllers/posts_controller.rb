class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :index]
  before_action :downcase_title, only: [:create,:update]
  load_and_authorize_resource
  helper_method :list_like_users
  def index
    friend_ids = current_user.friends.pluck(:id)
    friend_ids << current_user.id

    if params[:title].blank?
      @posts = Post.includes(:user).where(user_id: friend_ids).where(banned: false).order(created_at: :desc)

    else
      search_downcase = params[:title].downcase
      @posts = Post.includes(:user).where(user_id: friend_ids).where(banned: false).where("title LIKE ?", "%#{search_downcase}%").order(created_at: :desc)
    end

    @stories = Story.where(user_id: friend_ids).where('expires_at > ?', Time.now).order(created_at: :desc)

    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end

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
    unless post_params[:title].present? || post_params[:content].present? || post_params[:post_images][1].present?
      flash[:alert] = "At least one input needed."
      render :new, status: :unprocessable_entity
      return
    end
    
    @post = Post.new(post_params) 
    @post.user = @user
    if @post.save
      @user.friends.each do |friend|
        Notification.create(user: friend, message: "#{current_user.username} Upload a new Post.")
      end

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

  def list_like_users(likes)
    likes.each {|like| like}

    # @users.user.username
    # @uses = @likes.each{ |user| user.username}
  end

  private

  def downcase_title
    post_params[:title].downcase!
  end

  def post_params
    params.require(:post).permit(:title, :content, post_images: [])
  end
end
