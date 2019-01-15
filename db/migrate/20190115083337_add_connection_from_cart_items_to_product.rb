class AddConnectionFromCartItemsToProduct < ActiveRecord::Migration[5.2]
  def change
    add_reference :cart_items, :product, index: true
  end
end
