document.addEventListener('DOMContentLoaded', () =>{

    let avatarPreview = document.getElementById('edit_avatar_preview');
    let avatarInput = document.getElementById('edit_avatar')
    let edit_registration_form = document.getElementById('edit_registration_form')
    let edit_cropper;

    avatarInput?.addEventListener('change', function (e) {
        let file = e.target.files[0];
        let reader = new FileReader();
        reader.onload = function () {
            avatarPreview.src = reader.result;
            edit_cropper = new Cropper(avatarPreview, {
            });
        }
        reader.readAsDataURL(file);
    });

    edit_registration_form?.addEventListener('submit',   (e) => {
        e.preventDefault()

        let canvas = edit_cropper.getCroppedCanvas().toDataURL()
        let username = document.getElementById('edit_username').value
        let email = document.getElementById('edit_email').value
        let password = document.getElementById('edit_current_password').value
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
                window.location.href = '/'
            })
            .catch(e => console.log(e))
    })

})
