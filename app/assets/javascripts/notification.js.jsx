//Place all the behaviors and hooks related to the matching controller here.
//All this logic will automatically be available in application.js.

$(function(){
  $('#userNoti').on('click',function(e, element) {
    e.preventDefault();
    $('#userNoti .alerts.dropdown-menu').toggle();
  });

  setInterval(function() {
    notificationsCollection.fetch({
      success: function(notifications) {

        notificationsComp = _.map(notifications.models,
          function(notification,key) {
            return(<NotificationItem key={notification.id}
                                    message={notification.attributes.message}
                                    className="text-center" />);
        });

        React.render(
          <UserNotifications notifications = {notifications}
                            notificationsComp = {notificationsComp} />,
          document.getElementById('notificationsW')
        );
      },
      error: function() {
        React.render(
          <UserNotifications 
              notificationsComp = {<NotificationItem
                message="Notifications could not be loaded."
                className="text-center" />}
          />,
          document.getElementById('notificationsW')
        );
      }
    });
  }, 500);

  React.render(<UserNotifications />,
               document.getElementById('notificationsW'));
})
