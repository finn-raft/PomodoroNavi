class AddProfileToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :profile, :text
  end
end
