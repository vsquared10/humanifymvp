require "paperclip/matchers"

fixture_path_for_tests = ":rails_root/public/system/:rails_env/:class/:attachment/:id_partition/:filename"
Paperclip::Attachment.default_options[:path] = fixture_path_for_tests

RSpec.configure do |config|
  config.include Paperclip::Shoulda::Matchers

  config.after(:suite) do
    paths_to_clean = [
      Dir["#{Rails.root}/spec/test_files/"],
      Dir["#{Rails.root}/public/listing_offers/"],
      Dir["#{Rails.root}/public/listings/"],
      Dir["#{Rails.root}/public/test/"]
    ]

    paths_to_clean.each do |path_with_paperclip_images|
      Rails.logger.info "deleting: #{path_with_paperclip_images}"
      FileUtils.rm_rf path_with_paperclip_images
    end
  end
end
