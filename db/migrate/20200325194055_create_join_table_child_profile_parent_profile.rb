class CreateJoinTableChildProfileParentProfile < ActiveRecord::Migration[6.0]
  def change
    create_table :child_profiles_parent_profiles do |t|
      t.references :parent_profile, null: false, foreign_key: { to_table: :aggregate_profile_details }
      t.references :child_profile, null: false, foreign_key: { to_table: :profiles }
    end
  end
end
