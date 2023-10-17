document.addEventListener('DOMContentLoaded', () =>{

    let editAvatarPreview = document.getElementById('edit-avatar-preview');
    let avatarInput = document.getElementById('edit_avatar')
    let edit_registration_form = document.getElementById('edit_registration_form')
    let cropper ;

    if(editAvatarPreview){
        editAvatarPreview.src = editAvatarPreview.dataset.userAvatar
    }

    avatarInput?.addEventListener('change', function (e) {
        let file = e.target.files[0];
        let reader = new FileReader();
        reader.onload = function () {
            editAvatarPreview.src = reader.result;
            cropper = new Cropper(editAvatarPreview, {
            });
        }
        reader.readAsDataURL(file);
    });

    edit_registration_form?.addEventListener('submit',   (e) => {
        e.preventDefault()

        let canvas = cropper?.getCroppedCanvas().toDataURL()
        let username = document.getElementById('user_username').value
        let email = document.getElementById('user_email').value
        let password = document.getElementById('user_password').value
        let password_confirmation = document.getElementById('user_password_confirmation').value
        let current_password = document.getElementById('user_current_password').value
        let date = document.getElementById('user_date').value
        let phone_input = document.getElementById('phone-input')
        let iti = window.intlTelInputGlobals.getInstance(phone_input);
        let phone_number = iti.getNumber()
        fetch('/users', {
            method: 'PATCH',
            headers: {
                "Content-Type": "application/json",
                'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
            },
            body: JSON.stringify({
                user:{
                    cropped_img : canvas,
                    username,
                    password,
                    email,
                    date,
                    phone_number,
                    password_confirmation,
                    current_password
                },
            })
        })
            .then(res => res.json())
            .then(data => {
                window.location.href = '/'
            })
            .catch(e => console.log(e))
    })

})
