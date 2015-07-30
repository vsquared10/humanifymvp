var NotificationItem = React.createClass({

  render: function() {
    return(
       <li className={this.props.className}>
        {this.props.message}
       </li>
    );
  }
});
