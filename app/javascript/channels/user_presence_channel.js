import consumer from "./consumer"

document.addEventListener('DOMContentLoaded', function() {
  consumer.subscriptions.create("UserPresenceChannel", {
    connected() {
      console.log('connected from user presence')
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      console.log(data)
      // Called when there's incoming data on the websocket for this channel
    }
  });
})

