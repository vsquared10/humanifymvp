class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.string :conversation_uuid
    end
  end
end
