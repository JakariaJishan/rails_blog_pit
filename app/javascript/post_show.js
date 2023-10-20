let post_show_input = document.getElementById('post_image_input')
let post_show_preview = document.getElementById('post_image_preview')

post_show_input.addEventListener('change', (e) =>{
    let file = e.target.files[0];
    let reader = new FileReader();
    reader.onload = function () {
        post_show_preview.src = reader.result;
    }
    reader.readAsDataURL(file)
})
