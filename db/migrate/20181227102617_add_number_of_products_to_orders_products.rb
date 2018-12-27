class AddNumberOfProductsToOrdersProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :orders_products, :number_product, :decimal
    drop_table :order_products
  end
end
