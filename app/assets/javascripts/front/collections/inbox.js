Humanify.Collections.InboxCollection = Backbone.Collection.extend({
  model: Humanify.Models.Inbox,
  url: '/inbox.json'
});
