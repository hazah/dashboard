class CreateConcernAreas < ActiveRecord::Migration[6.0]
  def change
    create_table :concern_areas do |t|
      t.references :natural_guild, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
    add_index :concern_areas, :name, unique: true
  end
end
