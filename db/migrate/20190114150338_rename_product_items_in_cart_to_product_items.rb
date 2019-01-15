class RenameProductItemsInCartToProductItems < ActiveRecord::Migration[5.2]
  def change
    rename_table :product_items_in_carts, :product_items
  end
end
