var InboxList = React.createClass({
  inboxPath: function() {
    if (this.props.unreadCount > 5) {
      return 'See More'
    } else if (this.props.unreadCount <= 5) {
      return 'View Inbox'
    }
  },
  render: function() {
    return(
      <ul className={this.props.className} aria-labelledby="alerts">
        {this.props.inboxItems}
        <li className="text-center">
          <a href="/inbox">
            {this.inboxPath()}
          </a>
        </li>
      </ul>
    );
  }
});
