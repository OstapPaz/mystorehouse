class AddConnectionFromCartItensToCart < ActiveRecord::Migration[5.2]
  def change
    add_reference :cart_items, :cart, index: true
  end
end
