class AddPriceToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :price, :decimal, null: false
  end
end
