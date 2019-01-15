class ChangeNameProductCart < ActiveRecord::Migration[5.2]
  def change
    rename_table :product_item_in_carts, :product_items_in_carts
  end
end
