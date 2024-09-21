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
      if (data.action === 'delete') {
        console.log(data)
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
            <div class="flex items-center gap-2 justify-end my-3 group/item">
              <div class="bg-[#007D2A] max-w-[500px] rounded-[20px] text-white px-5 overflow-auto py-2 break-words">
                <p>${content}</p>
              </div>
              <button onclick="deleteMessage(${messageId})" class="invisible group-hover/item:visible">
               <svg xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="20" height="50" viewBox="0 0 24 24" fill="red">
                <path d="M 10 2 L 9 3 L 3 3 L 3 5 L 21 5 L 21 3 L 15 3 L 14 2 L 10 2 z M 4.3652344 7 L 5.8925781 20.263672 C 6.0245781 21.253672 6.877 22 7.875 22 L 16.123047 22 C 17.121047 22 17.974422 21.254859 18.107422 20.255859 L 19.634766 7 L 4.3652344 7 z"></path>
              </svg>
            </button>
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


