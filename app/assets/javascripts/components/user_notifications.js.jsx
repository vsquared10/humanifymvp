var notificationsCollection = new Humanify.Collections.NotificationsCollection;

var UserNotifications = React.createClass({
  mixins: [Backbone.React.Component.mixin],
  getDefaultProps: function() {
    return {
      notifications: {length: ""},
      notificationsComp: []
    };
  },
  render: function() {
    if(this.props.notifications.length == 0){
      this.props.notifications.length = ""
    }
    return (
      <div>
        <span className="badge">{this.props.notifications.length}</span>
        <NotificationsList notificationsComp={this.props.notificationsComp}
                          className="alerts dropdown-menu"/>
      </div>
    );
  }
});

setInterval(function() {
  notificationsCollection.fetch({
    success: function(notifications) {

      notificationsComp = _.map(notifications.models,
        function(notification,key) {
          return(<NotificationItem key={notification.id}
                                  message={notification.attributes.message} />);
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
            notificationsComp = {<NotificationItem message="Notifications could not be loaded."/>}
        />,
        document.getElementById('notificationsW')
      );
    }
  });
}, 500);

React.render(
  <UserNotifications />,
  document.getElementById('notificationsW')
);
