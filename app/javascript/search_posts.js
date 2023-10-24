const search_input = document.getElementById('search-input')
const search_results = document.getElementById('search-results')

search_input.addEventListener('input', (e)=>{
    // e.preventDefault()
    let title = search_input.value
    console.log(title.length)
    if(title.length > 0){
    fetch(`/?title=${title}`, {
        headers:{
            'Accept': 'application/json',
        }
    })
        .then(res => res.json())
        .then(data => {
            console.log(data)
            search_results.innerHTML = ''
            data.forEach(post =>{
                let li = document.createElement('li')
                let a = document.createElement('a')
                a.href = `/posts/${post.id}`
                a.textContent = post.title
                li.appendChild(a)
                search_results.appendChild(li)
            })

        })
        .catch(e => console.log(e))
    }else{
        search_results.innerHTML = ''
    }
})