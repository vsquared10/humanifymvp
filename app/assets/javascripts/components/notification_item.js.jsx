var NotificationItem = React.createClass({

  render: function() {
    return(
       <li>
        {this.props.message}
       </li>
    );
  }
});
