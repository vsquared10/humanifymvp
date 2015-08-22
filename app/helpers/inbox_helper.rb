module InboxHelper
  def conversation_past_day?(id)
   created_date = current_user.mailbox.inbox.find(id).created_at
   Time.now() > created_date + 1.day
  end
end
