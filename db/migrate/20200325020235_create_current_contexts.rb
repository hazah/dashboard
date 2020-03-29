class CreateCurrentContexts < ActiveRecord::Migration[6.0]
  def change
    create_table :current_contexts do |t|
      t.references :context, null: false, foreign_key: true
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
