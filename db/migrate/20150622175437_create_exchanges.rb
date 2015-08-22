class CreateExchanges < ActiveRecord::Migration
  def change
    create_table :exchanges do |t|
      t.integer :amount
      t.integer :destination
      t.integer :source
      t.boolean :reversed, default: false
      t.string :status
      t.string :description

      t.timestamps null: false
    end
  end
end
