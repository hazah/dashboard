class CreateCurrentBasicProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :current_basic_profiles do |t|
      t.references :basic_profile, null: false, foreign_key: { to_table: :profiles }
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
