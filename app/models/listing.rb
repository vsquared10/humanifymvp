class Listing < ActiveRecord::Base
	belongs_to :user

	has_attached_file :image, 
    styles: { :medium => "300x300>", :thumb => "100x100>" },
    default_url: "small_Humanify.png"

	# Validate content type
  validates_attachment_content_type :image, :content_type => /\Aimage/

  validates :description, presence: true
  validates :image, presence: true
  validates :title, presence: true
  validates :points, presence: true

  validates_inclusion_of :list_type, in: %w{ ask offer communtiy_project }

  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :topics
end
