json.user_id @mailbox.messageable.id
json.mail do
  json.array! @mailbox.inbox.each do |conversation|
    json.id conversation.id
    json.subject conversation.subject
    json.(conversation, :created_at, :updated_at)
    json.unread conversation.is_unread?(@mailbox.messageable)

    receipts = conversation.receipts_for(@mailbox.messageable)
    json.messages conversation.messages.each do |message|
      json.id message.id
      json.body message.body
      json.(message, :created_at, :updated_at)
      json.sender do
        json.id message.sender.id
        json.name message.sender.name
      end
    end
  end
end
