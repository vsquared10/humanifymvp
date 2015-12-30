class CreateCommunityProject < ActiveRecord::Migration
  def change
    create_table :community_projects do |t|
      t.belongs_to :listing, index:true
    end
  end
end
