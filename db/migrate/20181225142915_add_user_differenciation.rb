class AddUserDifferenciation < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :admin_permission, :boolean, :default => false
  end
end
