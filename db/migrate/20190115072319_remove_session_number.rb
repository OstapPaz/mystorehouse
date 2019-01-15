class RemoveSessionNumber < ActiveRecord::Migration[5.2]
  def change
    remove_column :carts, :session_number
    change_column :carts, :session_id, :string
    add_index :carts, :session_id
  end
end
