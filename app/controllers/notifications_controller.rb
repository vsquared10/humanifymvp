class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index 
    @notifications = current_user.unread_notifications
    respond_to do |format|
      format.html { render json: @notifications.to_json }
      format.json { render json: @notifications.to_json }
    end
  end

  def destroy
  end
end
