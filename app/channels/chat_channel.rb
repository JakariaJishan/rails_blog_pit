class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    sender = User.find(data['sender_id'])
    recipient = User.find(data['recipient_id'])

    message = Message.create(content: data['content'], sender: sender, recipient: recipient)

    ActionCable.server.broadcast( "chat_channel", {message:message})

  end

end
