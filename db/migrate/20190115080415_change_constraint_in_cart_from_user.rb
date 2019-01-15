class ChangeConstraintInCartFromUser < ActiveRecord::Migration[5.2]
  def change
    rename_column :carts, :users_id, :user_id
    change_column_null :carts, :user_id, true
  end
end
