class Bid < Offer
  validate :listing_type_offer,
           :offer_more_than_highest_valid_bid,
           :offer_more_than_listing_amount,
           :offer_less_than_user_balance

  validates_numericality_of :points, greater_than: 0

  private

  def listing_type_offer
    if self.listing.listing_type != "offer"
      errors.add(:base,
                 'You can make a bid only on listings that offer for something.')
    end
  end
  def offer_more_than_listing_amount
    unless self.points.nil? and self.points >= self.listing.points
      errors.add(:base, 'You cannot make a offer lower than listing amount.')
    end
  end

  def offer_more_than_highest_valid_bid
    if self.listing.highest_offer.present?
      unless self.points.nil? and self.points > self.listing.highest_offer.points
        errors.add(:base, 'Try making a offer higher than the highest bid.')
      end
    end
  end

  def offer_less_than_user_balance
    unless self.points.nil? and self.user.points >= self.points
      errors.add(:base, 'You do not have enough karma points.')
    end
  end
end
