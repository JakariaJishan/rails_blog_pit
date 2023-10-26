let post_show_input = document.getElementById('show-post-input')
let post_show_preview = document.getElementById('show-preview-post')

post_show_input?.addEventListener('change', (e) =>{
    let file = e.target.files;
    for (let i = 0; i<file.length; i++){
        let reader = new FileReader();
        reader.onload = function (e) {
            let img = document.createElement('img')
            img.src = e.target.result
            img.style.height = "100px"
            img.style.width = "200px"
            img.style.objectFit = "cover"
            post_show_preview.appendChild(img)
        }
        reader.readAsDataURL(file[i])
        // console.log(file[i])
    }
})


let new_post_input = document.getElementById('new-post')
let post_preview = document.getElementById('preview-post')
new_post_input?.addEventListener('change', (e) =>{
   let file = e.target.files;
   for (let i = 0; i<file.length; i++){
       let reader = new FileReader();
       reader.onload = function (e) {
           let img = document.createElement('img')
            img.src = e.target.result
            img.style.height = "100px"
           img.style.width = "200px"
           img.style.objectFit = "cover"
           post_preview.appendChild(img)
       }
       reader.readAsDataURL(file[i])
       // console.log(file[i])
   }
    // post_preview.appendChild('')

})