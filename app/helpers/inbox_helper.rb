module InboxHelper
  def conversation_past_day?(id)
   created_date = current_user.mailbox.conversations.find(id).created_at
   Time.now() > created_date + 1.day
  end

  def participants(conversation,user)
    return conversation.participants.delete_if {|p| p.id == user.id }
  end
end
