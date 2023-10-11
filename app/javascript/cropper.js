document.addEventListener('DOMContentLoaded', () =>{

    let avatarPreview = document.getElementById('avatar-preview');
    let avatarInput = document.getElementById('avatar')
    let registration_form = document.getElementById('registration_form')
    let edit_registration_form = document.getElementById('edit_registration_form')
    let cropper;

    avatarInput?.addEventListener('change', function (e) {
        let file = e.target.files[0];
        let reader = new FileReader();
        reader.onload = function () {
            avatarPreview.src = reader.result;
            cropper = new Cropper(avatarPreview, {
            });
        }
        reader.readAsDataURL(file);
    });

    registration_form?.addEventListener('submit',   (e) => {
        e.preventDefault()

        let canvas = cropper.getCroppedCanvas().toDataURL()
        let username = document.getElementById('user_username').value
        let email = document.getElementById('user_email').value
        let password = document.getElementById('user_password').value
        let password_confirmation = document.getElementById('user_password_confirmation').value

           fetch('/users', {
                method: 'POST',
                headers: {
                    "Content-Type": "application/json",
                    'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
                },
                body: JSON.stringify({
                    user:{
                        cropped_img : canvas,
                        username:username,
                        password,
                        email,
                        password_confirmation
                    },
                })
            })
               .then(res => res.json())
               .then(data => {
                   window.location.href = '/'
               })
               .catch(e => console.log(e))

    })
//    update user profile
    edit_registration_form?.addEventListener('submit',   (e) => {
        e.preventDefault()

        let canvas = cropper.getCroppedCanvas().toDataURL()
        let username = document.getElementById('user_username').value
        let email = document.getElementById('user_email').value
        let password = document.getElementById('user_password').value
        let password_confirmation = document.getElementById('user_password_confirmation').value
        fetch('/users', {
            method: 'POST',
            headers: {
                "Content-Type": "application/json",
                'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
            },
            body: JSON.stringify({
                user:{
                    cropped_img : canvas,
                    username:username,
                    password,
                    email,
                    password_confirmation
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
