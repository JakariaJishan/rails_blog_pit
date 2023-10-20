
let new_post_input = document.getElementById('new-post')
let post_preview = document.getElementById('preview-post')
new_post_input.addEventListener('change', (e) =>{
   let file = e.target.files[0];
   let reader = new FileReader();
   reader.onload = function () {
      post_preview.src = reader.result;
   }
   reader.readAsDataURL(file)
})
let phone_input = document.getElementById('phone-input')
console.log(phone_input)
if(phone_input){
   intlTelInput(phone_input, {
      utilsScript: "https://cdn.jsdelivr.net/npm/intl-tel-input@18.2.1/build/js/utils.js",
      separateDialCode: true,
      initialCountry: "bd",
   });
}

