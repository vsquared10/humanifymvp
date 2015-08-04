class RemoveLayerSessions < ActiveRecord::Migration
  def change
    drop_table :layer_sessions
  end
end
