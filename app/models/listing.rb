class Listing < ActiveRecord::Base
  has_many :offers
  has_many :exchanges

  belongs_to :user

  has_attached_file :image,
    styles: { :medium => "300x300>", :thumb => "100x100>" },
    default_url: "small_Humanify.png"


  validates_presence_of :description, :image, :title, :visibility
  validates_presence_of :points, unless: :community_project?

  validates_attachment_content_type :image, :content_type => /\Aimage/

  validates_inclusion_of :status, in: %w{ pending accepted closed }
  validates_inclusion_of :list_type, in: %w{ ask offer community_project }
  validates_inclusion_of :visibility, in: %w{ global local }
  validate :listing_type_options

  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :topics

  before_save :set_city

  has_many :reviews
  has_many :claims

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

  private

  def listing_type_options
    if self.list_type == "ask"
      unless self.points == 0
        errors.add(:base, 'An listing that asks for something must be free.')
      end
    end
  end

  def set_city
    self.city = self.user.zip_code.to_s.to_region(city: true)
  end

  def community_project?
    self.list_type == "community_project"
  end
end
