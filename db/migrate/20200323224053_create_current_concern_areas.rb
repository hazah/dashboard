class CreateCurrentConcernAreas < ActiveRecord::Migration[6.0]
  def change
    create_table :current_concern_areas do |t|
      t.references :concern_area, null: false, foreign_key: true
      t.references :profile, null: false, foreign_key: true
      t.references :natural_guild, null: false, foreign_key: true

      t.timestamps
    end
  end
end
