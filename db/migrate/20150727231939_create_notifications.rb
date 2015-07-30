class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :message
      t.boolean :viewed, default: false

      t.timestamps null: false
    end
  end
end
