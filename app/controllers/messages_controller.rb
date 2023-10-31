class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)

    if @message.save
      # Broadcast the message to the chat channel
      ChatChannel.broadcast_to([@message.sender, @message.recipient], message: render_message(@message))
      head :ok
    else
      render json: { errors: @message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :sender_id, :recipient_id)
  end

  def render_message(message)
    ApplicationController.render(partial: 'messages/message', locals: { message: message })
  end
end
