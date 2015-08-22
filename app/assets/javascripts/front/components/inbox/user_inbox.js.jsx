var InboxNotifications = React.createClass({
  mixins: [Backbone.React.Component.mixin],
  getDefaultProps: function() {
    return {
      inboxComponents: [],
      unreadCount: "",
      className: "inbox-alerts alerts dropdown-menu"
    };
  },
  componentDidMount: function() {},
  render: function() {
    return (
      <div>
        <span className="badge count">{this.props.unreadCount}</span>
        <InboxList inboxItems={this.props.inboxComponents}
                   unreadCount={this.props.unreadCount}
                   className={this.props.className}/>
      </div>
    );
  }
});
