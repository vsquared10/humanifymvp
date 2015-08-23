class User < ActiveRecord::Base
  include PublicActivity::Model

  acts_as_messageable
  has_merit

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :conversations

  has_many :listings
  has_many :listing_offers
  has_many :listing_asks
  has_many :listing_communities
  has_many :exchanges
  has_many :offers
  has_many :notifications
  has_many :reviews

  validates :name, presence: true
  validates_format_of :zip_code,
    with: /\A(\d{5}\z)|(\d{5}-\d{4}\z)/, presence: true

  after_create :init_karma
  after_create :set_id
  # Move to Messages Concern
  def messages(id)
    self.mailbox.inbox.find(id)
        .messages.order(created_at: :desc)
  end
  def url_params 
    "#{self.id}/#{URI.escape(self.name)}"
  end

  private

  def init_karma
    self.add_points(250)
  end

  def set_id
    now = Time.now
    macro = now.strftime("%y%m").to_f
    micro = now.strftime("%d%k").to_f

    self.id = macro + self.id + micro
  end

end
