class InboxController < ApplicationController
  before_action :authenticate_user!

  def index
    @mailbox = current_user.mailbox
  end

  def show
    @mailbox = current_user.mailbox
  end

  def new
    @user = User.find(params[:id])
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
      @mail = current_user.send_message(
                recipient,
                message[:message],
                message[:subject]
              )

      redirect_to "/users/#{recipient.url_params}"
    end
  end

  def destroy
  end

  private
    def message
      params.require(:mailbox).permit(:id, :recipient_id,
                                      :message, :subject)
    end
end
