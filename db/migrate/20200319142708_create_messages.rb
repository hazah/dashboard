class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.text :raw_content

      t.timestamps
    end
  end
end
