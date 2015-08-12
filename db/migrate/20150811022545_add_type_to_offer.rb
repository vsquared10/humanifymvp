class AddTypeToOffer < ActiveRecord::Migration
  def change
    add_column :offers, :type, :string
  end
end
