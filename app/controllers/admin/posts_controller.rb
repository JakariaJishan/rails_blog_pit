class Admin::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin
  def index
    @posts = Post.all
  end

  def ban_post
    post = Post.find(params[:id])
    post.ban!
    redirect_to admin_posts_path, notice: 'Post has been banned'
  end

  def unban_post
    post = Post.find(params[:id])
    post.unban!
    redirect_to admin_posts_path, notice: 'Post has been unbanned'
  end

  private

  def authorize_admin
    redirect_to root_path, alert: 'Access Denied' unless current_user.isAdmin?
  end

end