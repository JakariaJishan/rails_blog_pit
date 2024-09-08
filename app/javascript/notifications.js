// Toggle notification popup visibility
document.querySelector('.notification-btn').addEventListener('click', function(e) {
    const popup = document.getElementById('notification-popup');
    popup.classList.toggle('hidden'); // Toggle visibility
    e.stopPropagation()
});

// window.addEventListener('click', () => {
//     const popup = document.getElementById('notification-popup');
//     if (!popup.classList.contains('hidden')) {
//         popup.classList.add('hidden');
//     }
// })

document.querySelector('.read-all').addEventListener('click', function() {
    const notificationList = document.getElementById('notification-count');
    notificationList.classList.add('hidden'); // Read all notifications

    fetch('/notifications/notification_read_all', { method: 'PATCH' })
        .then(response => response.json())
        .then(data => {
            console.log(data);
        });
})

// Clear All notifications button (just UI example, backend handling needed)
document.querySelector('.clear-all').addEventListener('click', function() {
    const notificationList = document.getElementById('notifications');
    notificationList.innerHTML = ''; // Clear all notifications

    fetch('/notifications/notification_clear', { method: 'DELETE' })
        .then(response => response.json())
        .then(data => {
            console.log(data);
        });
});


document.addEventListener('DOMContentLoaded', function() {
    fetch('/notifications.json')
        .then(response => response.json())
        .then(notifications => {
            const notificationsList = document.getElementById('notifications');
            const notificationBadge = document.getElementById('notification-count');
            notifications.forEach(notification => {
                const li = document.createElement('li');
                li.className = 'p-2 border-b notification-list-item';
                li.textContent = notification.message;
                notificationsList.appendChild(li);

                if(notification.read === false) {
                    notificationBadge.classList.remove('hidden');
                }
            });
        });
});
