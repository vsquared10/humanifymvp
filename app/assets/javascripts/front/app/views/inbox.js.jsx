var inboxChannel = pusher.subscribe('inbox');
var inboxCollection = new Humanify.Collections.InboxCollection;

$('#inboxMenu').children().on('click', function() {
  $('#inboxMenu .inbox-alerts.dropdown-menu').toggle();
});

var getInbox = function() {
  inboxCollection.fetch({
    success: function(inbox) {

      var inboxComponents =  _.map(inbox.models,
        function(mail,key) {
          return(<InboxItem key={mail.id}
                            message={mail.attributes.message}
                            url={mail.attributes.url}
                            className="" />);
        });

      React.render(
        <InboxNotifications
          inboxComponents = {inboxComponents} />,
        document.getElementById('inboxMenuComp')
      );
    },
    error: function() {
      React.render(
        <InboxNotifications
            inboxComponents = {<InboxItem
              message="Your inbox could not be loaded. : ("
              className="text-center" />}
        />,
        document.getElementById('inboxMenuComp')
      );
    }
  });
}

// Get inbox on "new-message" Pusher event
inboxChannel.bind('new-message', function(){
  getInbox();
});

getInbox();
