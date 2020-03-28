class CreateNetworkModes < ActiveRecord::Migration[6.0]
  def change
    create_table :network_modes do |t|
      t.string :type

      t.timestamps
    end
  end
end
