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
      const active_user = document.getElementsByClassName('active_user')
      if (data.onLine === 'on'){
        console.log('update')
      active_user.classList.add('bottom-0 x left-7 absolute  w-3.5 h-3.5 bg-green-500 border-2 border-white  rounded-full')
      }else{
        console.log('down')
        active_user.classList.add('bottom-0 y left-7 absolute  w-3.5 h-3.5  rounded-full')
      }
      // Called when there's incoming data on the websocket for this channel
    }
  });
})

