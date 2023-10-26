let post_classes = document.getElementsByClassName('post-class')
let like_count = document.getElementsByClassName('like-count')
let like_btn = document.getElementById('like')
let like_popup = document.getElementsByClassName('like-popup')
    for (let i = 0; i< post_classes.length; i++){
        post_classes[i].addEventListener('click', (e)=>{
            e.preventDefault()
            let post_id = post_classes[i].id
            let like_id = post_classes[i].dataset.likeId
            let initialState = post_classes[i].dataset.initialState
            if(initialState === 'true'){
                fetch(`posts/${post_id}/likes/${like_id}`, {
                    method: 'DELETE',
                    headers: {
                        "Content-Type": "application/json",
                        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
                    },
                    body: JSON.stringify({like: {post_id, id:like_id}})
                }).then(res => res.json())
                    .then(data => {
                        like_count[i].innerHTML = `${data.liked_number} loves`
                        post_classes[i].dataset.initialState = "false"
                        post_classes[i].children[0].style.fill = 'none'
                        post_classes[i].children[0].style.stroke = 'currentColor'
                    })
                    .catch(e => {
                        console.log(e)
                    })
            }else{
                fetch(`posts/${post_id}/likes`,{
                    method: 'POST',
                    headers: {
                        "Content-Type": "application/json",
                        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
                    },
                    body: JSON.stringify({like: {post_id}})
                }).then(res => res.json())
                    .then(data => {
                        like_count[i].innerHTML = `${data.liked_number} loves`
                        post_classes[i].dataset.initialState = "true"
                        post_classes[i].dataset.likeId =data.like_id
                        post_classes[i].children[0].style.fill = 'red'
                        post_classes[i].children[0].style.stroke = 'red'
                    })
                    .catch(e => {
                        console.log(e)
                        window.location.href='/users/sign_in'
                    })
            }

        })
    }

    // fetch('')
for (let i = 0; i < like_count.length; i++){
    like_count[i].addEventListener('click', (e)=>{
        fetch(`posts/liked_users/${like_count[i].id}`, {
            headers: {
                "Content-Type": "application/json",
            },
        }).then(res => res.json())
            .then(data => {
                like_popup[i].innerHTML = ''

               data.users.forEach(user => {
                   let li = document.createElement('li')
                   let img = document.createElement('img')
                   let span = document.createElement('span')
                   img.src = user.avatar
                   span.innerHTML = user.userName
                   li.appendChild(img)
                   li.appendChild(span)
                   img.style.cssText = `
                    height:30px;
                    width:30px;
                    border-radius: 100%;
                   `
                   li.style.cssText =`
                   display: flex;
                   align-items: center;
                   gap: 10px;
                   margin-bottom:5px;
                   `
                   like_popup[i].appendChild(li)
               })
                like_popup[i].classList.toggle('hidden')

            })
            .catch(e => console.log(e))
        // like_popup[i].classList.toggle('hidden')
        // e.stopPropagation()
    })
    // window.addEventListener('click', ()=>{
    //     like_popup[i].classList.add('hidden')
    // })
}
