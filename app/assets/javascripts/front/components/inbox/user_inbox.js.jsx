var inboxCollection = new Humanify.Collections.InboxCollection;

var InboxNotifications = React.createClass({
  mixins: [Backbone.React.Component.mixin],
  getDefaultProps: function() {
    return {
      inboxComponents: [],
      className: "inbox-alerts dropdown-menu"
    };
  },

  inboxCount: function() {
    return this.props.inboxComponents.length;
  },
  render: function() {
    return (
      <div>
        <span className="badge">{this.inboxCount()}</span>
        <InboxList notificationsItems={this.props.notificationsComponents}
                          className={this.props.className}/>
      </div>
    );
  }
});
