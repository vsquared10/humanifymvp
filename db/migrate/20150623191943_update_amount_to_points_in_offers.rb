class UpdateAmountToPointsInOffers < ActiveRecord::Migration
  def change
    remove_column :offers, :amount
    add_column :offers, :points, :integer
  end
end
