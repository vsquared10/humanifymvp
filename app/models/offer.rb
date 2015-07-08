class Offer < ActiveRecord::Base
  belongs_to :listing
  belongs_to :user

  validates_presence_of :points
  validates_inclusion_of :status, in: %w{ pending accepted declined }
  validate :user_doesnt_own_listing, on: :create
  validate :offer_more_than_highest_valid_bid, on: :create
  validate :offer_more_than_listing_amount, on: :create
  validate :offer_less_than_user_balance
  validate :user_posted_listing?, on: "update"

  private

  def user_doesnt_own_listing
    if self.listing.posted_by?(self.user)
      errors.add(:base, 'You cannot make a offer on you own listing.')
    end
  end

  def offer_more_than_listing_amount
    unless self.points >= self.listing.points
      errors.add(:base, 'You cannot make a offer lower than listing amount.')
    end
  end

  def offer_more_than_highest_valid_bid
      if self.listing.highest_offer.present? and self.points >= self.listing.highest_offer.points
        errors.add(:base, 'Try making a offer higher than the highest bid.')
      end
  end

  def offer_less_than_user_balance
    unless self.user.points >= self.points
      errors.add(:base, 'You do not have enough karma points.')
    end
  end

  def user_posted_listing?
    #Validate if current user posted listing
  end
end
