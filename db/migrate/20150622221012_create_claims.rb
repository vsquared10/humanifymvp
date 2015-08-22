class CreateClaims < ActiveRecord::Migration
  def change
    create_table :claims do |t|
      t.string :status
      t.boolean :reversed, default: false
      t.integer :amount

      t.timestamps null: false
    end
  end
end
