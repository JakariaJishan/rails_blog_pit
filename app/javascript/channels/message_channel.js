import consumer from "./consumer"

 consumer.subscriptions.create("MessageChannel", {
  connected() {
    console.log('connected')
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log('rended', data)
    // Called when there's incoming data on the websocket for this channel
    // let messageDisplay = document.getElementById('message-display')
    // messageDisplay.innerHTML = `<article class="message">
    //           <div class="message-header">
    //             <p>${data.user.email}</p>
    //           </div>
    //           <div class="message-body">
    //             <p>${data.message.body}</p>
    //           </div>
    //         </article>`

  }
});

// document.addEventListener('DOMContentLoaded', ()=>{
//   let message_form = document.getElementById('new_message')
//   message_form?.addEventListener('submit', (e)=>{
//     e.preventDefault()
//     const message_input = document.getElementById('message-input').value
//     console.log(message_input)
//     if (message_input === '') return;
//     const message = {
//       body: message_input
//     }
//     messageChannel.send({message: message})
//   })
//
// })