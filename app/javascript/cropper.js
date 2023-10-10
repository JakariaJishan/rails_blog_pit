
    // var avatarInput = document.getElementById('avatar-input');
    var avatarPreview = document.getElementById('avatar-preview');
    let avatarInput = document.getElementById('avatar')
    let croppedImg = document.getElementById('avatar-show')
    let cropper;

    avatarInput.addEventListener('change', function (e) {
        var file = e.target.files[0];
        var reader = new FileReader();
        reader.onload = function () {
            avatarPreview.src = reader.result;
            cropper = new Cropper(avatarPreview, {
                aspectRatio: 16 / 9
            });
        }
        reader.readAsDataURL(file);
    });


    // const crop = document.getElementById('cropper')
    //
    // crop.addEventListener('click', (e)=>{
    //     let canvas = cropper.getCroppedCanvas()
    //     e.preventDefault()
    //     croppedImg.src = canvas.toDataURL()
    //
    // })

    document.querySelector('form').addEventListener('submit',  async (e) => {
        e.preventDefault()

        let canvas = cropper.getCroppedCanvas().toDataURL()
           const res = await fetch('/users', {
                method: 'POST',
                headers: {
                    "Content-Type": "application/json",
                    // "Content-Type": "multipart/form-data",
                    // 'Content-Type': 'application/x-www-form-urlencoded',
                    'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
                },
                body: JSON.stringify({
                    user:{
                        cropped_img : canvas
                    }
                })
            })
            const data = await res.json()
            // console.log(data)


        // canvas.toBlob(blob => {
        //     let formData = new FormData();
        //     // formData.append('user[avatar]', blob, 'avatar.jpg');
        //     formData.append('user[username]', username)
        //     formData.append('user[email]', email)
        //     formData.append('user[password]', password)
        //     formData.append('user[password_confirmation]', confirmation_password)
        //     // formData.append('date', date)
        //     console.log({...formData})
        //     fetch('/users', {
        //             method: 'POST',
        //             headers:{
        //                 "Accept": "application/json",
        //                 "Content-Type": "multipart/form-data"
        //             },
        //             body: [...formData],
        //         }).then(response => {
        //             // Handle response
        //             console.log(response,'requested');
        //         });

        //     })

    })

