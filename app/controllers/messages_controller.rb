class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    sender = User.find(params[:message][:sender_id])
    recipient = User.find(params[:message][:recipient_id])
    chat_id = [sender.id, recipient.id].sort.join('')
    if @message.save!
      ActionCable.server.broadcast "chat_channel_#{chat_id}",
                                   { message: @message, action: 'create' }
      head :no_content
    else
      head :bad_request
    end
  end

  def destroy
    @message = Message.find(params[:id])
    chat_id = [@message.sender.id, @message.recipient.id].sort.join('')

    if @message.sender_id == current_user.id
      @message.destroy
      ActionCable.server.broadcast "chat_channel_#{chat_id}", { message: @message, action: 'delete' }
      head :no_content
    else
      head :forbidden
    end
  end
  private

  def message_params
    params.require(:message).permit(:content, :sender_id, :recipient_id)
  end

end
