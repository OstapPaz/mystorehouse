class RenameColumnCountToAmount < ActiveRecord::Migration[5.2]
  def change
    rename_column :orders_products, :count, :amount
  end
end
