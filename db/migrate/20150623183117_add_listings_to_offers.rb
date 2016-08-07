class AddListingsToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :listing_id, :integer
  end
end
