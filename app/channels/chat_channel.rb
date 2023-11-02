class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel_#{params[:chat_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed

  end

  def speak(data)

    sender = User.find(data['sender_id'])
    recipient = User.find(data['recipient_id'])
    chat_id =  [sender.id, recipient.id].sort.join("")
    message = Message.create(content: data['content'], sender: sender, recipient: recipient)
    data = {
      message: message,
    }
    ActionCable.server.broadcast( "chat_channel_#{chat_id}", {message:data})

  end

end
