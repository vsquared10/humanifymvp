var notificationsChannel = pusher.subscribe('notifications');
var notificationsCollection = new Humanify.Collections.NotificationsCollection;

$('#notificationsMenu').children().on('click', function() {
  $('#notificationsMenuComp .alerts.dropdown-menu').toggle();
});

var getNotifications = function() {
  notificationsCollection.fetch({
    success: function(notifications) {

      var notificationsComponents =  _.map(notifications.models,
        function(notification,key) {
          return(<NotificationItem key={notification.attributes.id}
                                   message={notification.attributes.message}
                                   url={notification.attributes.url}
                                   className="text-center" />);
        });

      ReactDOM.render(
        <NotificationsMenu
          notificationsComponents = {notificationsComponents} />,
        document.getElementById('notificationsMenuComp')
      );
    },
    error: function() {
      ReactDOM.render(
        <NotificationsMenu
              notificationsComponents = {<NotificationItem
              message="Notifications could not be loaded."
              className="text-center" />}
        />,
        document.getElementById('notificationsMenuComp')
      );
    }
  });
}

// Get notifications on "new-notification" Pusher event
notificationsChannel.bind('new-notification', function(){
  getNotifications();
});

getNotifications();
