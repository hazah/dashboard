class CreateCurrentConversations < ActiveRecord::Migration[6.0]
  def change
    create_table :current_conversations do |t|
      t.references :profile, null: false, foreign_key: true
      t.references :conversation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
