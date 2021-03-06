class AddSlugsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :slug, :string
    add_index :users, :slug, unique: true
    add_index :users, :username, unique: true
  end
end
