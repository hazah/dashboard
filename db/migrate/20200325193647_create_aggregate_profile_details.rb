class CreateAggregateProfileDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :aggregate_profile_details do |t|
      t.references :aggregate_profile, null: false, foreign_key: { to_table: :profiles }

      t.timestamps
    end
  end
end
