class CityToLisitings < ActiveRecord::Migration
  def change
    add_column :listings, :city, :string
  end
end
