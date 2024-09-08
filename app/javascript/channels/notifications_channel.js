import consumer from "./consumer"

document.addEventListener('DOMContentLoaded', function () {

    consumer.subscriptions.create("NotificationsChannel", {
        connected() {
            // Called when the subscription is ready for use on the server
            console.log("Connected to the notifications channel!");
        },

        disconnected() {
            // Called when the subscription has been terminated by the server
        },

        received(data) {
            console.log(data)
            const notificationsList = document.getElementById('notifications');
            const li = document.createElement('li');
            li.className = 'p-2 border-b notification-list-item';
            li.textContent = data.message;

            // Add new notification to the top of the list
            notificationsList.prepend(li);

            // Optionally: show a notification count or alert
            const notificationBadge = document.getElementById("notification-count");
            if (notificationBadge) {
                notificationBadge.classList.remove('hidden');
            }
        }
    })
});
