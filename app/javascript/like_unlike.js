let post_classes = document.getElementsByClassName('post-class')
let like_count = document.getElementsByClassName('like-count')
    for (let i = 0; i< post_classes.length; i++){
        post_classes[i].addEventListener('click', (e)=>{
            e.preventDefault()
            let post_id = post_classes[i].id
            let like_id = post_classes[i].dataset.likeId
            let initialState = post_classes[i].dataset.initialState
            if(initialState === 'true'){
                console.log('inside delete')
                fetch(`posts/${post_id}/likes/${like_id}`, {
                    method: 'DELETE',
                    headers: {
                        "Content-Type": "application/json",
                        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
                    },
                    body: JSON.stringify({like: {post_id, id:like_id}})
                }).then(res => res.json())
                    .then(data => {
                        like_count[i].innerHTML = data.liked_number
                        post_classes[i].dataset.initialState = "false"
                        post_classes[i].classList.remove('text-red-500')
                        post_classes[i].classList.add('text-gray-500')
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
                        like_count[i].innerHTML = data.liked_number
                        post_classes[i].dataset.initialState = "true"
                        post_classes[i].dataset.likeId =data.like_id
                        post_classes[i].classList.remove('text-gray-500')
                        post_classes[i].classList.add('text-red-500')
                    })
                    .catch(e => {
                        console.log(e)
                        window.location.href='/users/sign_in'
                    })
            }



        })
    }


