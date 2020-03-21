class CreateCurrentTemperaments < ActiveRecord::Migration[6.0]
  def change
    create_table :current_temperaments do |t|
      t.references :temperament, null: false, foreign_key: true

      t.timestamps
    end
  end
end
