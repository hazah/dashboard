class CreateHumanDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :human_details do |t|
      t.references :human, null: false, foreign_key: { to_table: :agents }

      t.timestamps
    end
  end
end
