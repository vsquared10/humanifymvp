var notificationsChannel = pusher.subscribe('notifications');

$('#userNoti').on('click', function() {
  $('#userNoti .alerts.dropdown-menu').toggle();
});

var getNotifications = function() {
  notificationsCollection.fetch({
    success: function(notifications) {

      var notificationsComponents =  _.map(notifications.models,
        function(notification,key) {
          return(<NotificationItem key={notification.id}
                                  message={notification.attributes.message}
                                  url={notification.attributes.url}
                                  className="text-center" />);
        });

      React.render(
        <UserNotifications
          notificationsComponents = {notificationsComponents} />,
        document.getElementById('notificationsW')
      );
    },
    error: function() {
      React.render(
        <UserNotifications
            notificationsComponents = {<NotificationItem
              message="Notifications could not be loaded."
              className="text-center" />}
        />,
        document.getElementById('notificationsW')
      );
    }
  });
}

// Get notifications on "new-notification" Pusher event
notificationsChannel.bind('new-notification', function(){
  getNotifications();
});

getNotifications();
