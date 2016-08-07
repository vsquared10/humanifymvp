var NotificationItem = React.createClass({
  render: function() {
    return(
      <li>
        <a href={this.props.url}>
          {this.props.message}
        </a>
      </li>
    );
  }
});
