class Listing < ActiveRecord::Base
  has_many :offers
  has_many :exchanges
  has_many :reviews
  has_many :claims
  belongs_to :user

  has_attached_file :image,
    styles: { :medium => "300x300>", :thumb => "100x100>" },
    default_url: "small_Humanify.png"


  validates_presence_of :description, :image, :title, :visibility
  validates_attachment_content_type :image, :content_type => /\Aimage/
  validates_inclusion_of :type,
                         in: %w{ ListingAsk ListingOffer ListingCommunity }
  validates_inclusion_of :status, in: %w{ pending accepted closed }
  validates_inclusion_of :visibility, in: %w{ global local }

  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :topics
  acts_as_messageable

  before_save :set_location


  attr_writer :form_part

  def days_left
    unless self.duration.nil?
      exp = self.expiration.day - Time.now.day
      "#{exp} day".pluralize(exp)
    end
  end

  def expiration
    unless self.duration.nil?
      self.created_at + self.duration.days
    end
  end

  def expired?
    unless self.duration.nil?
      self.expiration.day - Time.now.day <= 0
    end
  end

  def closed?
    self.status != "pending"
  end

  def self.open_global
    self.where(["visibility = :visibility or status = :status",{
      visibility:"global", status:"pending"}])
  end

  def accepted?
    self.status == "accepted"
  end

  def accepted_user
    self.offers.where(status: "accepted").first.user
  end

  def points_starting
    self.valid_offers.present? ? self.highest_offer.points : self.points
  end

  def highest_offer
    self.offers.where(status:"pending").order("points DESC").first
  end

  def valid_offers
    self.offers.where(status:"pending")
  end

  def posted_by?(user)
    self.user == user
  end

  def listing_type
    list = {
      "ListingOffer":"offer",
      "ListingAsk":"ask",
      "ListingCommunity":"community_project"
    }
    return list[self.type.to_sym]
  end

  def form_part
    @form_part || parts.first
  end

  def parts
    %w[ type offer default ]
  end

  def listing_offer
    offer = {
      "ListingOffer":"offer",
      "ListingAsk":"ask",
      "ListingCommunity":"community"
    }
    return offer[self.type.to_sym]
  end

  private

  def set_location
    unless self.location == self.user.zip_code.to_s.to_region(city: true)
      self.location = self.user.zip_code.to_s.to_region(city: true)
    end
  end

  def community_project?
    self.list_type == "community_project"
  end
end
