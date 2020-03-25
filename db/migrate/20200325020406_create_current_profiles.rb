class CreateCurrentProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :current_profiles do |t|
      t.references :current_profile, null: false, foreign_key: { to_table: :profiles }
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
