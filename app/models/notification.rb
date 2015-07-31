class Notification < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :message

  after_save :send_alert
  # action :string "object#action"

  private

  def send_alert
    Pusher.trigger('notifications','new-notification',{})
  end
end
