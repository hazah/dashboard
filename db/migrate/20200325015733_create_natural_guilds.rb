class CreateNaturalGuilds < ActiveRecord::Migration[6.0]
  def change
    create_table :natural_guilds do |t|
      t.string :name

      t.timestamps
    end
    add_index :natural_guilds, :name, unique: true
  end
end
