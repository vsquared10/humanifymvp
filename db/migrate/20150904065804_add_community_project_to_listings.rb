class AddCommunityProjectToListings < ActiveRecord::Migration
  def change
    add_column :listings, :community_project_id, :integer
  end
end
