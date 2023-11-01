class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
  end

  private

  def message_params
    params.require(:message).permit(:content, :sender_id, :recipient_id)
  end

  def render_message(message)
    ApplicationController.render(partial: 'messages/message', locals: { message: message })
  end
end
