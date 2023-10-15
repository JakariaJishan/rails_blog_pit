// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import "@hotwired/turbo-rails"
import "controllers"
import './cropper'
import './popup'
import './edit_cropper'

window.addEventListener('load', () =>{
    let toast = document.getElementById('toast')
    setInterval(()=>{
        toast.classList.remove('opacity-100')
        toast.classList.add('opacity-0')
    },3000)
})
