var InboxNotifications = React.createClass({
  mixins: [Backbone.React.Component.mixin],
  getDefaultProps: function() {
    return {
      inboxComponents: [],
      className: "inbox-alerts alerts dropdown-menu"
    };
  },

  inboxCount: function() {
    return this.props.inboxComponents.length;
  },
  render: function() {
    return (
      <div>
        <span className="badge count">{this.inboxCount()}</span>
        <InboxList inboxItems={this.props.inboxComponents}
                          className={this.props.className}/>
      </div>
    );
  }
});
