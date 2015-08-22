require 'elasticsearch/model'

class ListingOffer < Listing
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  validates_presence_of :points

  validate :listing_duration_length

  private

  def listing_duration_length
    if self.duration
      errors.add(:base, 'Listing duration can only be 1,3,5,7,10 days.') unless [1,3,5,7,10].include?(self.duration)
    end
  end
end
