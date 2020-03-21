class CreatePasswordCredentialData < ActiveRecord::Migration[6.0]
  def change
    create_table :password_credential_data do |t|
      t.references :password_credential, null: false, foreign_key: { to_table: :credentials }
      t.references :email_address, null: false, foreign_key: true
      t.references :password_model, null: false, foreign_key: { to_table: :passwords }
      
      t.timestamps
    end
  end
end
