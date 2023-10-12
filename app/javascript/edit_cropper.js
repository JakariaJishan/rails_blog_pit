document.addEventListener('DOMContentLoaded', () =>{

    let editAvatarPreview = document.getElementById('edit-avatar-preview');
    let avatarInput = document.getElementById('edit_avatar')
    let edit_registration_form = document.getElementById('edit_registration_form')
    let cropper ;

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

        let canvas = cropper.getCroppedCanvas().toDataURL()
        let username = document.getElementById('user_username').value
        let email = document.getElementById('user_email').value
        let password = document.getElementById('user_current_password').value
        fetch('/users', {
            method: 'PATCH',
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
                },
            })
        })
            .then(res => res.json())
            .then(data => {
                console.log(data)
                window.location.href = '/'
            })
            .catch(e => console.log(e))
    })

})
