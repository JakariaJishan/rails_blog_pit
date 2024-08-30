class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
  end

  def destroy
    @message = Message.find(params[:id])
    if @message.sender_id == current_user.id
      @message.destroy
      ActionCable.server.broadcast "chat_channel_#{params[:chat_id]}",
                                   { message_id: @message.id, action: 'delete' }
      head :ok
    else
      head :forbidden
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
