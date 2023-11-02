// import { createConsumer } from "@rails/actioncable"
import consumer from "./consumer";

document.addEventListener('DOMContentLoaded', function() {
  const senderId = document.getElementById('sender_id').value
  const recipientId = document.getElementById('recipient_id').value
  const chat_id = [senderId, recipientId].sort().join("")
  const chatChannel = consumer.subscriptions.create({channel: "ChatChannel", chat_id: chat_id}, {
    connected() {
      console.log('connected')
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      console.log(data.message)
      const isCurrentUserSender = data.message.message.sender_id === data.message.current_user.id;
      const messages = document.getElementById('messages')
      messages.insertAdjacentHTML('beforeend', `
      <div>
        <div class="flex items-center gap-5 justify-${isCurrentUserSender ? 'end' : 'start'} my-3">
          <div class="${isCurrentUserSender ? 'bg-[#007D2A] text-white' : 'bg-[#F0F0F0]'} px-5 overflow-auto py-2 rounded-full break-words">
            <p>${data.message.message.content}</p>
          </div>
        </div>
      </div>
  `)
    },

    speak(content) {
      this.perform('speak', { content: content, sender_id: senderId, recipient_id: recipientId })
    }
  })
  const form = document.getElementById('new_message')
  form.addEventListener('submit', function(e) {
    const input = document.getElementById('message_content')
    const content = input.value
    chatChannel.speak(content)
    input.value = ''
    e.preventDefault()
  })
})
