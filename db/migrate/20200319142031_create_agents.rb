class CreateAgents < ActiveRecord::Migration[6.0]
  def change
    create_table :agents do |t|
      t.string :name
      t.references :email_address, null: false, foreign_key: true

      t.timestamps
    end
  end
end
