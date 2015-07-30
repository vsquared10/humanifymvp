class User < ActiveRecord::Base
  include PublicActivity::Model

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :layer_session
  has_many :conversations

  has_many :listings
  has_many :exchanges
  has_many :offers
  has_many :notifications

  validates :name, presence: true
  validates_format_of :zip_code,
    with: /\A(\d{5}\z)|(\d{5}-\d{4}\z)/, presence: true

  after_create :init_karma

  acts_as_messageable
  has_merit

  def mailboxer_email(object)
    email
  end

  def unread_notifications
    self.notifications.all.where(viewed: false).order("created_at desc")
  end

  private

  def init_karma
    self.add_points(250)
  end

end
