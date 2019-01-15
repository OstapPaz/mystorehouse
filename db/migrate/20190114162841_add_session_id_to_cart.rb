class AddSessionIdToCart < ActiveRecord::Migration[5.2]
  def change
    add_column :carts, :session_number, :string
    add_reference :carts, :users, index: true
    add_index :carts, :session_number
  end
end
