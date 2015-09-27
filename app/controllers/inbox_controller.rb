class InboxController < ApplicationController
  before_action :set_mailbox, only: [:show, :index, :new]
  before_action :authenticate_user!

  def index
  end

  def show
  end

  def new
  end

  def create

    if message[:id]
      conversation = current_user.mailbox.conversations.find(message[:id])
    end

    if conversation.present?
      @mail = current_user.reply_to_conversation(
                conversation,
                message[:message],
                should_untrash = true
              )

      redirect_to :back
    else
      recipient = User.find(message[:recipient_id])
      subject = "Hi #{recipient.name}" || message[:subject]
      @mail = current_user.send_message(
                recipient,
                message[:message],
                subject
              )
      redirect_to inbox_path(@mail.conversation.id)
    end
  end

  def destroy
  end

  private
    def message
      params.require(:mailbox).permit(:id, :recipient_id,
                                      :message, :subject)
    end

    def set_mailbox
      if current_user.present?
        @mailbox = current_user.mailbox
      end
    end
end
