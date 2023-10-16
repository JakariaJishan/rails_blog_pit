const open_btn = document.getElementById('open')
const popup = document.getElementById('popup')

const post_dot =  document.getElementById('post-dot')
const post_popup = document.getElementById('post-popup')

const comment_dot = document.getElementById('comment-dot')
const comment_popup = document.getElementById('comment-popup')

open_btn?.addEventListener('click', (e)=>{
    popup.classList.toggle('hidden')

    e.stopPropagation()
    // location.reload()
})

post_dot?.addEventListener('click', (e) =>{
    post_popup.classList.toggle('hidden')
    e.stopPropagation()
})
comment_dot?.addEventListener('click', (e) =>{
    comment_popup.classList.toggle('hidden')
    e.stopPropagation()
})

window.addEventListener('click', e =>{
    if(!popup?.contains(e.target)){
        popup?.classList.add('hidden')
    }
    if(!post_popup?.contains(e.target)){
        post_popup?.classList.add('hidden')
    }
    if(!comment_popup?.contains(e.target)){
        comment_popup?.classList.add('hidden')
    }
})


