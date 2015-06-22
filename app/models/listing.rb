class Listing < ActiveRecord::Base
  has_many :exchanges
  belongs_to :user

  has_attached_file :image,
    styles: { :medium => "300x300>", :thumb => "100x100>" },
    default_url: "small_Humanify.png"


  validates_presence_of :description, :image, :title, :points, :visibility

  validates_attachment_content_type :image, :content_type => /\Aimage/

  validates_inclusion_of :list_type, in: %w{ ask offer communtiy_project }
  validates_inclusion_of :visibility, in: %w{ global local }

  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :topics

  before_save :set_city

  has_many :reviews

  private

  def set_city
    self.city = self.user.zip_code.to_s.to_region(city: true)
  end
end
