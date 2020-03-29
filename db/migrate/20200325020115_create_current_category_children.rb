class CreateCurrentCategoryChildren < ActiveRecord::Migration[6.0]
  def change
    create_table :current_category_children do |t|
      t.references :parent, null: false, foreign_key: { to_table: :categories }
      t.references :category, null: false, foreign_key: true
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
