# Note: ActiveRecord should not be used for this rake task.
# lib/tasks/update_expired_listings_status.rake
desc 'Update status of expired listings to closed.'

task update_expired_listings_status: :environment do
  Listing.all.each do |l|
    unless l.duration.nil?
      l.update(status:"closed") if l.expired?
    end
  end
end
