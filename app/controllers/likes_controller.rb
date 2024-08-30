class LikesController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!, only: [:create, :destroy]
  load_and_authorize_resource

  def create
      @post = Post.find(like_params[:post_id])
      @like = @post.likes.new(user_id:current_user.id, likes_type: 'post')
      @user_like = @post.likes.find{ |like| like.user_id == current_user.id}
      if @like.save
        render json: {liked_number: @post.likes.count, like_id: @user_like.id }, status:  :ok
      end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = @post.likes.find(params[:id])
    @user_like = @post.likes.find{ |like| like.user_id == current_user.id}
    if @like.destroy
      render json: {liked_number: @post.likes.count, like_id: @user_like.id } , status: :ok
    end
  end

  def liked_users
    @post = Post.find(params[:post_id])
    @likes = @post.likes
    response = @likes.map do |like|
      user = like.user
      avatar = url_for(user.avatar)
      user_name = user.username
      {
        userName:user_name,
        avatar: avatar,
      }
    end
    # @users = @likes.map {|like| like.user}
    # @avatars = @users.map{|user| user.avatar }
    render json: {users: response}

  end

  def like_question
    @question = Question.find(params[:question_id])
    @like = @question.likes.new(user_id:current_user.id, likes_type: 'question')
    @user_like = @question.likes.find{ |like| like.user_id == current_user.id}
    if @like.save!
      redirect_back(fallback_location: root_path)
    end
  end

  def like_answer
    @answer = Answer.find(params[:answer_id])
    @like = @answer.likes.new(user_id:current_user.id, likes_type: 'answer')
    @user_like = @answer.likes.find{ |like| like.user_id == current_user.id}
    if @like.save
      redirect_back(fallback_location: root_path)
    end
  end

  def unlike_question
    @question = Question.find(params[:question_id])
    @like = @question.likes.find_by(user_id: current_user.id)
    if @like.destroy
      redirect_back(fallback_location: root_path)

    end
  end

  def unlike_answer
    @answer = Answer.find(params[:answer_id])
    @like = @answer.likes.find_by(user_id: current_user.id)
    if @like.destroy
      redirect_back(fallback_location: root_path)
    end
  end
end

private

def like_params
  params.require(:like).permit(:post_id, :answer_id, :question_id)
end