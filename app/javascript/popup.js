const open_btn = document.getElementById('open')
const popup = document.getElementById('popup')

open_btn?.addEventListener('click', (e)=>{
    popup.classList.toggle('hidden')

    e.stopPropagation()
    // location.reload()
})

window.addEventListener('click', e =>{
    if(!popup?.contains(e.target)){
        popup?.classList.add('hidden')
    }
})

window.addEventListener('load', () =>{
    let toast = document.getElementById('toast')
    setInterval(()=>{
        toast.classList.add('opacity-0')
    },2000)
})

