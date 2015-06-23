class RenameClaimsToOffers < ActiveRecord::Migration
  def change
    rename_table :claims, :offers
  end
end
