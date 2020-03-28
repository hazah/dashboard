class CreateConversations < ActiveRecord::Migration[6.0]
  def change
    create_table :conversations do |t|
      t.references :aggregate_profile, null: false, foreign_key: { to_table: :profiles }

      t.timestamps
    end
  end
end
