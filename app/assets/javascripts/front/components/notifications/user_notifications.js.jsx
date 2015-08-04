var notificationsCollection = new Humanify.Collections.NotificationsCollection;

var UserNotifications = React.createClass({
  mixins: [Backbone.React.Component.mixin],
  getDefaultProps: function() {
    return {
      notificationsComponents: [],
      className: "alerts dropdown-menu"
    };
  },
  notificationsCount: function() {
    return this.props.notificationsComponents.length;
  },
  notificationsItems: function() {
      return this.props.notificationsComponents;
  },
  render: function() {
    return (
      <div>
        <span className="badge">{this.notificationsCount()}</span>
        <NotificationsList notificationsItems={this.notificationsItems()}
                          className={this.props.className}/>
      </div>
    );
  }
});
