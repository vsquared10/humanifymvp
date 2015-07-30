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
