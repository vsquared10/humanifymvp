class InboxController < ApplicationController
  before_action :authenticate_user!

  def index
    @mailbox = current_user.mailbox
  end

  def show
    @mailbox = current_user.mailbox
  end

  def create
    @mail = current_user.send_message(message_params)
  end

  def destroy
  end

  private
    def listing_params
      params.require(:listing).permit(
        :title,
        :list_type,
        :description,
        :image,
        :points,
        :visibility,
        :tag_list)
    end
end
