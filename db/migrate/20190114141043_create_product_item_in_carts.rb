class CreateProductItemInCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :product_item_in_carts do |t|

      t.integer :quantity

      t.timestamps
    end
  end
end
