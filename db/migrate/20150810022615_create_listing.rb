class CreateListing < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :type
      t.string :description
      t.integer :user_id
      t.string :title
      t.integer :points
      t.string :visibility
      t.string :location
      t.string :status, default: "pending"
      t.integer :duration
      t.attachment :image
      t.timestamps
    end
  end
end
