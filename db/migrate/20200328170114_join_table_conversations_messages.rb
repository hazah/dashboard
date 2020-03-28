class JoinTableConversationsMessages < ActiveRecord::Migration[6.0]
  def change
    create_join_table :conversations, :messages do |t|
      # t.index [:conversation_id, :message_id]
      # t.index [:message_id, :conversation_id]
    end
  end
end
