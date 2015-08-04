var inboxChannel = pusher.subscribe('inbox');

$('li#inbox').on('click', function() {
  //$('#userNoti .alerts.dropdown-menu').toggle();
});

var getInbox = function() {
  inboxCollection.fetch({
    success: function(inbox) {

      var inboxComponents =  _.map(inbox.models,
        function(message,key) {
          return(<inboxItem key={message.id}
                                  message={message.attributes.message}
                                  url={message.attributes.url}
                                  className="" />);
        });

      React.render(
        <InboxNotifications
          inboxComponents = {inboxComponents} />,
        document.getElementById('inboxCount')
      );
    },
    error: function() {
      React.render(
        <InboxNotifications
            inboxComponents = {<InboxItem
              message="Your inbox could not be loaded. : ("
              className="text-center" />}
        />,
        document.getElementById('inboxCount')
      );
    }
  });
}

// Get inbox on "new-message" Pusher event
inboxChannel.bind('new-message', function(){
  getInbox();
});

getInbox();
