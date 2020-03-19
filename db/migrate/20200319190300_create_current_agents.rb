class CreateCurrentAgents < ActiveRecord::Migration[6.0]
  def change
    create_table :current_agents do |t|
      t.references :agent, null: false, foreign_key: true

      t.timestamps
    end
  end
end
