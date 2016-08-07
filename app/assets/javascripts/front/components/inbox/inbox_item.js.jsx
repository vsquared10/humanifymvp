var InboxItem= React.createClass({
  getDefaultProps: function() {
    return {
      message: "",
      className: "alerts dropdown-menu",
    };
  },
  previewMessage: function() {
    //debugger;
    return this.props.message.substr(0,35) + "...";
  },
  render: function() {
    return(
      <li className={this.props.className}>
      <a href={this.props.url}>
        {this.previewMessage()}
      </a>
      </li>
    );
  }
});
