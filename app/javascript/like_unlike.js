let post_classes = document.getElementsByClassName('post-class')
let like_count = document.getElementsByClassName('like-count')
let like_id ;
    for (let i = 0; i< post_classes.length; i++){
        post_classes[i].addEventListener('click', (e)=>{
            e.preventDefault()
            let post_id = post_classes[i].id
            let like_id = post_classes[i].dataset.likeId
            // let like_id = post_class[i].id.split("-")[3]
            // console.log("likeid", like_id)
            if(like_id){
                fetch(`posts/${post_id}/likes/${like_id}`, {
                    method: 'DELETE',
                    headers: {
                        "Content-Type": "application/json",
                        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
                    },
                    body: JSON.stringify({like: {post_id, id:like_id}})
                }).then(res => res.json())
                    .then(data => {
                        like_count[i].innerHTML = data.like_count
                        console.log("delete", data)
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
                        like_count[i].innerHTML = data.like_count
                        console.log(data)
                        // like_id = data[0].id
                    })
                    .catch(e => {
                        console.log(e)
                    })
            }



        })
    }


