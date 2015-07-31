var notificationsCollection = new Humanify.Collections.NotificationsCollection;

var UserNotifications = React.createClass({
  mixins: [Backbone.React.Component.mixin],
  getDefaultProps: function() {
    return {
      notificationsComponents: []
    };
  },

  notificationsCount: function() {
    return this.props.notificationsComponents.length;
  },
  render: function() {
    return (
      <div>
        <span className="badge">{this.notificationsCount()}</span>
        <NotificationsList notificationsItems={this.props.notificationsComponents}
                          className="alerts dropdown-menu"/>
      </div>
    );
  }
});
