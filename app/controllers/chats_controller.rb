class ChatsController < ApplicationController
  # before_action :authenticate_user!
  # def index
  #   @chats = Chat.all
  # end

  # def create
  #   @chat = current_user.chats.new(chat_params)
  #   @chat.save
  #   ActionCable.server.broadcast("chat_channel", @chat.as_json(include: :user))

  # end

  # private

  # def chat_params
  #   params.require(:chat).permit(:body)
  # end
end
