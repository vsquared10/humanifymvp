Humanify.Models.Notification = Backbone.Model.extend({
  urlRoot: '/notifications'
});

// Move this to another file.
Humanify.Collections.NotificationsCollection = Backbone.Collection.extend({
  model: Humanify.Models.Notification,
  url: '/notifications'
});

$('#userNoti').on('click',function(e, element){
  $('#userNoti .alerts.dropdown-menu').toggle();
})
