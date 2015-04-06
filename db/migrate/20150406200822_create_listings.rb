class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :description

      t.timestamps null: false
    end
  end
end
