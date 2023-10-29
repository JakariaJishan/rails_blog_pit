class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @messages = Message.all
  end

  def create
    # raise params.inspect
    # @message = current_user.messages.new(body: params[:body])
    # @message.save
    # ActionCable.server.broadcast('message', @message.as_json(include: :user))
    ActionCable.server.broadcast('message', { body:"jacki" })
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
