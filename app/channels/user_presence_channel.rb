class UserPresenceChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "user_presence"
    # ActionCable.server.broadcast('user_presence', {user:current_user.id, online: 'on'})
    current_user.online = true
    current_user.save!
    ActionCable.server.broadcast('user_presence', {user: current_user.id, online:"on"})
  end

  def unsubscribed
    current_user.online = false
    current_user.save!

    ActionCable.server.broadcast('user_presence', {user: current_user.id, online:"off"})
  end
end
