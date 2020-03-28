class CreateCurrentNetworkModes < ActiveRecord::Migration[6.0]
  def change
    create_table :current_network_modes do |t|
      t.references :network_mode, null: false, foreign_key: true
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
