class CreateCurrentNaturalGuilds < ActiveRecord::Migration[6.0]
  def change
    create_table :current_natural_guilds do |t|
      t.references :natural_guild, null: false, foreign_key: true
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
