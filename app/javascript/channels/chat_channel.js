import consumer from "./consumer"

const chatChannel = consumer.subscriptions.create("ChatChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log('connected')
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log("received", data)
    const displayChat = document.getElementById('display-chat')
    displayChat.insertAdjacentHTML('beforeend',`<article class="chat">
              <div class="chat-header">
                <p>${data.user.email}</p>
              </div>
              <div class="chat-body">
                <p>${data.body}</p>
              </div>
            </article>`)
  },

});


document.addEventListener('DOMContentLoaded', ()=>{
  const chat_form = document.getElementById('new_chat')
  chat_form.addEventListener('click', (e) => {
    e.preventDefault()
    let chat_input = document.getElementById('chat-input').value
    if (chat_input === ''){
      return;
    }
    const chat ={
      body:chat_input
    }

    chatChannel.send({body:chat})

    fetch('/chats', {
      method:'POST',
      headers: {
        "Content-Type": "application/json",
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({
        chat:{
          body:chat_input
        }
      })
    }).then(res =>res.json())
        .then(data => console.log(data))
        .catch(e => console.log(e))

    chat_form.reset()

  })
})
