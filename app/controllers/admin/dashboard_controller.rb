class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin

  def index
    @total_users = User.count
    @total_posts = Post.count
    @total_comments = Comment.count
    @total_videos = Reel.count
    @average_posts_per_user = Post.group(:user_id).count.values.sum / @total_users.to_f

  end

  private

  def authorize_admin
    redirect_to root_path, alert: 'Access Denied' unless current_user.isAdmin?
  end
end
