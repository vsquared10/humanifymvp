var InboxList = React.createClass({
  render: function() {
    return(
      <ul className={this.props.className} aria-labelledby="alerts">
        {this.props.inboxItems}
      </ul>
    );
  }
});
