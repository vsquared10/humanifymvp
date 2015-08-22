var NotificationsMenu = React.createClass({
  mixins: [Backbone.React.Component.mixin],
  getDefaultProps: function() {
    return {
      notificationsComponents: [],
      className: "alerts dropdown-menu",
    };
  },
  notificationsCount: function() {
    if (this.props.notificationsComponents.length > 0){
      return this.props.notificationsComponents.length;
    }
  },
  notificationsItems: function() {
      return this.props.notificationsComponents;
  },
  render: function() {
    return (
      <div>
        <span className="badge count">{this.notificationsCount()}</span>
        <NotificationsList notificationsItems={this.notificationsItems()}
                          className={this.props.className}/>
      </div>
    );
  }
});
