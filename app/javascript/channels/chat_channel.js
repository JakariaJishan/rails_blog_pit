import { createConsumer } from "@rails/actioncable"

const consumer = createConsumer()

document.addEventListener('DOMContentLoaded', function() {
  const senderId = document.getElementById('sender_id').value
  const recipientId = document.getElementById('recipient_id').value
  const chatChannel = consumer.subscriptions.create({channel: "ChatChannel", sender_id: senderId, recipient_id: recipientId}, {
    connected() {
      console.log('connected')
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      console.log(data)
      const messages = document.getElementById('messages')
      messages.insertAdjacentHTML('beforeend', data['message'])
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
