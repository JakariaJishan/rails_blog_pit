class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:ban, :unban]
  before_action :authenticate_user!
  before_action :authorize_admin
  def index
    @users = User.where.not(id: current_user.id).order(created_at: :desc)
  end

  def ban
    @user.ban!
    redirect_to admin_users_path, notice: 'User has been banned'
  end

  def unban
    @user.unban!
    redirect_to admin_users_path, notice: 'User has been unbanned'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_admin
    redirect_to root_path, alert: 'Access Denied' unless current_user.isAdmin?
  end
end
