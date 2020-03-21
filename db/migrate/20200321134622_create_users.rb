class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.references :credential, null: false, foreign_key: true
      t.datetime :expires_at, null: false

      t.timestamps
    end
  end
end
