// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import "@hotwired/turbo-rails"
import "controllers"
import './cropper'
import './popup'
import './edit_cropper'



window.addEventListener('load', () =>{
    let toast = document.getElementById('toast')
    console.log(toast)
    setInterval(()=>{
        toast.classList.remove('opacity-100')
        toast.classList.add('opacity-0')
    },1000)
})
let phone_input = document.getElementById('phone-input')
window.intlTelInput(phone_input, {
    utilsScript: "https://cdn.jsdelivr.net/npm/intl-tel-input@18.2.1/build/js/utils.js",
    separateDialCode: true,
});