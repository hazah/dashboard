class AddTypeToCredentials < ActiveRecord::Migration[6.0]
  def change
    add_column :credentials, :type, :string
  end
end
