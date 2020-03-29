class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.references :parent, null: true, foreign_key: { to_table: :categories }

      t.timestamps
    end
    add_index :categories, [:name, :parent_id], unique: true
  end
end
