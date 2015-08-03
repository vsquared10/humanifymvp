var NotificationItem = React.createClass({
  render: function() {
    return(
       <li className={this.props.className}>
        <a href={this.props.url}>
          {this.props.message}
        </a>
       </li>
    );
  }
});
