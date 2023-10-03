// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

const open_btn = document.getElementById('open')
const popup = document.getElementById('popup')


open_btn.addEventListener('click', (e)=>{
    popup.classList.toggle('hidden')
    e.stopPropagation()
    // location.reload()
})

window.addEventListener('click', e =>{
    if(!popup.contains(e.target)){
        popup.classList.add('hidden')
        // location.reload()
    }
})