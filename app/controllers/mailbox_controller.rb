class MailboxController < ApplicationController
  before_action :authenticate_user!

  def index
    @mail = current_user.mailbox.inbox.to_json
    respond_to do |format|
      format.html { render json: @mail }
      format.json { render json: @mail }
    end
  end

  def create
    @mail = current_user.send_message(message_params)
  end

  def destroy
  end

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
