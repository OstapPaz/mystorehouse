class RenameProductItemsToCartItems < ActiveRecord::Migration[5.2]
  def change
    rename_table :product_items, :cart_items
  end
end
