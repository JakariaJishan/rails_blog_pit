class SessionsController < Devise::SessionsController
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  def create
    super
    current_user.update(online: true)
  end

end