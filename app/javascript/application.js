// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import "@hotwired/turbo-rails"
import "controllers"
import './cropper'
import './popup'
import './edit_cropper'
import './like_unlike'
import './search_posts'
import './channels/index'
import './notifications'

window.addEventListener('load', () =>{
    let toast = document.getElementById('toast')
    setInterval(()=>{
        toast.classList.add('hidden')
    },5000)
})

const messages = document.getElementById('messages')
messages.scrollTop = messages.scrollHeight