class ChatChannel < ApplicationCable::Channel
  def subscribed
    sender = User.find(params[:sender_id])
    recipient = User.find(params[:recipient_id])

    stream_for [sender, recipient]
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    puts data
    sender = User.find(data['sender_id'])
    recipient = User.find(data['recipient_id'])

    message = Message.create(content: data['content'], sender: sender, recipient: recipient)

    ChatChannel.broadcast_to([sender, recipient], message: render_message(message))
  end

  private

  def render_message(message)
    ApplicationController.render(partial: 'messages/message', locals: { message: message })
  end
end
