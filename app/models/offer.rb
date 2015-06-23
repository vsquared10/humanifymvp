class Offer < ActiveRecord::Base
  belongs_to :listing
  belongs_to :user

  validates_presence_of :points
  validates_inclusion_of :status, in: %w{ pending accepted }
  validate :offer_less_than_user_balance

  private

  def offer_less_than_user_balance
    unless self.user.points > self.points
      errors.add(:base, 'You do not have enough karma points.')
    end
  end
end
