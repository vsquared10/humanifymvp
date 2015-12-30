class AddSplitToListings < ActiveRecord::Migration
  def change
    add_column :listings, :split, :integer, default: 50
  end
end
