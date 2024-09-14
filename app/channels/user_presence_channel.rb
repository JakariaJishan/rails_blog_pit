class UserPresenceChannel < ApplicationCable::Channel

  def subscribed
    stream_from 'user_presence'
    current_user.update(online:true)
    current_user.update(last_seen_at: Time.now)
    current_user.save
    ActionCable.server.broadcast('user_presence',{user:current_user.id, onLine:"on"})
  end

  def unsubscribed
    stream_from 'user_presence'
    current_user.update(online:false)
    current_user.save
    ActionCable.server.broadcast('user_presence',{user:current_user.id, onLine:"off"})
  end

end