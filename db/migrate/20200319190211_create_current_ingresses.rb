class CreateCurrentIngresses < ActiveRecord::Migration[6.0]
  def change
    create_table :current_ingresses do |t|
      t.references :ingress, null: false, foreign_key: true

      t.timestamps
    end
  end
end
