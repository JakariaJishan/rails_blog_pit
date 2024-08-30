class SavedPostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @saved_posts = current_user.saved_posts.includes(:post).order(created_at: :desc)
  end

  def create
    post = Post.find(params[:post_id])
    saved_post = current_user.saved_posts.build(post: post)

    if saved_post.save
      redirect_to post, notice: 'Post was successfully saved.'
    else
      redirect_to post, alert: 'You have already saved this post.'
    end
  end

  def destroy
    saved_post = current_user.saved_posts.find_by(post_id: params[:post_id])
    saved_post.destroy
    redirect_to post_path(params[:post_id]), notice: 'Post was successfully unsaved.'
  end

  private

  def post
    @post ||= Post.find(params[:post_id])
  end
end
