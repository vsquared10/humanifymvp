class AddAttributesToListings < ActiveRecord::Migration
  def change
    add_column :listings, :title, :string
    add_column :listings, :list_type, :string
    add_column :listings, :points, :integer
    add_column :listings, :visibility, :string
  end
end
