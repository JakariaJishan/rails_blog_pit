// import { createConsumer } from "@rails/actioncable"
import consumer from "./consumer";

document.addEventListener('DOMContentLoaded', function() {
  const senderId = document.getElementById('sender_id')?.value
  const recipientId = document.getElementById('recipient_id')?.value
  const recipientAvatar = document.getElementById('recipient_avatar')?.value
  const chat_id = [senderId, recipientId].sort((a,b)=>a-b).join("")
  consumer.subscriptions.create({channel: "ChatChannel", chat_id: chat_id}, {
    connected() {
      console.log('connected')
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      console.log(data)
      if (data.action === 'delete') {
        const messageElement = document.getElementById(`message_${data.message.id}`);
        if (messageElement) {
          messageElement.remove();
        }
      } else {
        const isCurrentUserSender = data.message.sender_id === Number(senderId);
        const messages = document.getElementById('messages');
        messages.scrollTop = messages.scrollHeight;
        messages.insertAdjacentHTML('beforeend', this.html(data.message.content, isCurrentUserSender, data.message.id));
        document.getElementById('message_content').value = '';
      }},

    html(content, isCurrentUserSender, messageId){
      return `
        ${isCurrentUserSender ? `
          <div id="message_${messageId}">
            <div class="flex items-start gap-5 justify-end my-3">
              <div class="bg-[#007D2A] max-w-[500px] rounded-[20px] text-white px-5 overflow-auto py-2 break-words">
                <p>${content}</p>
              </div>
            </div>
          </div>
        ` :`
          <div id="message_${messageId}">
            <div class="flex items-start gap-5 justify-start my-3">
              <div>
                <img src=${recipientAvatar} class="h-8 w-8 rounded-full" />
              </div>
              <div class="bg-[#F0F0F0] max-w-[500px] rounded-[20px] px-5 py-2 overflow-auto break-words">
                <p>${content}</p>
              </div>
            </div>
          </div>
        `}
      `;
    },

  })


})


