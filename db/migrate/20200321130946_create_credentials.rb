class CreateCredentials < ActiveRecord::Migration[6.0]
  def change
    create_table :credentials do |t|
      t.references :email_address, null: false, foreign_key: true
      t.references :password_model, null: false, foreign_key: { to_table: :passwords }
      t.references :agent, null: false, foreign_key: true

      t.timestamps
    end
  end
end
