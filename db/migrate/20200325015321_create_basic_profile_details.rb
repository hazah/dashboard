class CreateBasicProfileDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :basic_profile_details do |t|
      t.references :basic_profile, null: false, foreign_key: { to_table: :profiles }
      t.references :name_model, null: false, foreign_key: { to_table: :names }
      t.references :email_model, null: false, foreign_key: { to_table: :emails }

      t.timestamps
    end
  end
end
