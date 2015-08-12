class AddFieldsToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :rating, :integer
    add_column :reviews, :recommend, :boolean
  end
end
