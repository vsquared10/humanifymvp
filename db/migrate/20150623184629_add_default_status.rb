class AddDefaultStatus < ActiveRecord::Migration
  def change
    change_column :offers, :status, :string, default: "pending"
  end
end
