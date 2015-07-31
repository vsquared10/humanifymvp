class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.unread_notifications.to_json
    respond_to do |format|
      format.html { render json: @notifications }
      format.json { render json: @notifications }
    end
  end

  def destroy
  end
end
