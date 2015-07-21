class CreateLayerSession < ActiveRecord::Migration
  def change
    create_table :layer_sessions do |t|
      t.string :token
    end
  end
end
