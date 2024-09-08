class NotificationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @notifications = current_user.notifications.order(created_at: :desc)
    respond_to do |format|
      format.json { render json: @notifications }
      format.html
    end
  end
  def mark_as_read
    @notification = Notification.find(params[:id])
    @notification.update(read: true)
    head :ok
  end

  def notification_read_all
    @notifications = current_user.notifications
    @notifications.update_all(read: true)
    head :ok
  end
  def notification_clear
    @notifications = current_user.notifications
    @notifications.destroy_all
  end
end
