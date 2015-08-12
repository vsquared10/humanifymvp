class ListingCommunity < Listing
  has_many :listing_offers
  has_many :listing_asks
end
