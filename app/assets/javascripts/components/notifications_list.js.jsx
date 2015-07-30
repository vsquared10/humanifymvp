var NotificationsList= React.createClass({

  render: function() {
    return(
      <ul className={this.props.className} aria-labelledby="alerts">
        {this.props.notificationsComp}
      </ul>
    );
  }
});
