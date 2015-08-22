class InboxController < ApplicationController
  before_action :authenticate_user!

  def index
    @mailbox = current_user.mailbox
  end

  def show
    @mailbox = current_user.mailbox
  end

  def create
    conversation = current_user.mailbox.inbox.find(message[:id])

    @mail = current_user.reply_to_conversation(
              conversation,
              message[:message],
              should_untrash = true
            )

    redirect_to :back
  end

  def destroy
  end

  private
    def message
      params.require(:mailbox).permit(:id, :message)
    end
end
