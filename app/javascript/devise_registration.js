
let phone_input = document.getElementById('phone-input')
if(phone_input){
   intlTelInput(phone_input, {
      utilsScript: "https://cdn.jsdelivr.net/npm/intl-tel-input@18.2.1/build/js/utils.js",
      separateDialCode: true,
      initialCountry: "bd",
   });
}

