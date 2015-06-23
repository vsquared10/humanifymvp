class Offer < ActiveRecord::Base
  belongs_to :listing
  belongs_to :user

  validates_presence_of :points
  validates_inclusion_of :status, in: %w{ pending accepted }
end
