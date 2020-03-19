class CreateEmailAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :email_addresses do |t|
      t.string :email

      t.timestamps
    end
    add_index :email_addresses, :email, unique: true
  end
end
