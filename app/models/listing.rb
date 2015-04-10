class Listing < ActiveRecord::Base
	belongs_to :user

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "small_Humanify.png"
	# Validate content type
  validates_attachment_content_type :image, :content_type => /\Aimage/
end
