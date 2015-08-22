var inboxCollection = new Humanify.Collections.InboxCollection;

var renderInboxNotifications = function() {
  inboxCollection.fetch({
    success: function(inbox) {
      // Get Collection of unread mail
      var unreadObj =
        _.where(inbox.models[0].attributes.mail,{unread:true});
      
      // Create Array of first five Inbox Components
      var unreadInboxComponents =  _.map(unreadObj.slice(0,5),
        function(mail,key) {
          return(<InboxItem key={mail.id}
                            message={mail.messages[0].body}
                            id={mail.id}
                            className="text-center" />);
        });
      // Render Main Notification Component with InboxItems passed
      React.render(
        <InboxNotifications
          unreadCount = {unreadObj.length}
          inboxComponents = {unreadInboxComponents} />,
        document.getElementById('inboxMenuComp')
      );
    },
    error: function() {
    React.render(
      <InboxNotifications
          inboxComponents = {<InboxItem
            message="Your inbox could not be loaded." 
            className="text-center" />}
      />,
      document.getElementById('inboxMenuComp')
    );
    }
  });
}

$('#inboxMenu span').on('click', function(event) {
  event.preventDefault();
  $('#inboxMenu .inbox-alerts.dropdown-menu').toggle();
});

React.render(
  <InboxNotifications/>,
  document.getElementById('inboxMenuComp')
);

var inboxChannel = pusher.subscribe('inbox');
// Get inbox on "new-message" Pusher event
inboxChannel.bind('new-message', function(){
  renderInboxNotifications();
});

renderInboxNotifications();
