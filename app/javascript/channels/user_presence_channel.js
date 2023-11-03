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
      const active_user = document.getElementById(data.user)
      const green_dot = document.getElementById(`green_dot_${data.user}`)
      if (data.onLine === 'on'){
        active_user?.classList.remove('hidden')
        green_dot?.classList.remove('hidden')
        active_user?.classList.add('bg-green-500')
        green_dot?.classList.add('bg-green-500')

      }else{
        active_user?.classList.add('hidden')
        green_dot?.classList.add('hidden')

      }
      // Called when there's incoming data on the websocket for this channel
    }
  });
})

