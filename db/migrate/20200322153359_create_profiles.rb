class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :type
      t.references :agent, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
