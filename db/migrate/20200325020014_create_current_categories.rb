class CreateCurrentCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :current_categories do |t|
      t.references :category, null: false, foreign_key: true
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
