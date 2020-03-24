class CreateCredentials < ActiveRecord::Migration[6.0]
  def change
    create_table :credentials do |t|
      t.string :type
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
