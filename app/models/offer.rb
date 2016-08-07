class Offer < ActiveRecord::Base
  belongs_to :listing
  belongs_to :user

  validates_inclusion_of :status, in: %w{ pending accepted declined }

  validate :offer_not_expired, on: :create
  validate :user_doesnt_own_listing, on: :create

  after_save :notify_listing_offer

  def accept
    # Attempt to Exchange Points
    if self.points.present?
      offer_exchange = Exchange.transfer(self.user,
                                         self.listing.user,
                                         self.points)
      if offer_exchange.status == "paid"
        self.update(status: "accepted")
        self.listing.update(status: "accepted")

        self.user.notifications.create( #dup2
          message: "#{ self.listing.user.name } has accepted your offer.",
          url: "/listings/#{self.listing.id}")
        #Open dialogue message between both users
      end
    elsif self.points.nil?
      self.update(status: "accepted")
      self.listing.update(status: "accepted")

      self.user.notifications.create( #dup2
        message: "#{ self.listing.user.name } has accepted your offer.",
        url: "/listings/#{self.listing.id}")
      #Open dialogue message between both users
    end
  end

  def decline
    self.update(status: "declined")
    self.user.notifications.create(
      message: "#{ self.listing.user.name } has decided not to take your offer.",
      url: "/listings/#{self.listing.id}")
  end

  private
  # Notifications
  def notify_listing_offer
    unless self.listing.offers.count > 4
      self.listing.user.notifications.create(
        message: "Your post for #{ self.listing.title} has a new offer.",
        url: "/listings/#{self.listing.id}")
    end
  end

  # Custom Validations
  def user_doesnt_own_listing
    if self.listing.posted_by?(self.user)
      errors.add(:base, 'You cannot make a offer on you own listing.')
    end
  end

  def offer_not_expired
    if self.listing.listing_type == "offer" and self.listing.expired?
      errors.add(:base, 'Listing has expired.')
    end
  end
end
