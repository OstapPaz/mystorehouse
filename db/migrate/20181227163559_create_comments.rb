class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :text
      t.decimal :rating
      t.belongs_to :user, show: true
      t.belongs_to :product, show: true
      t.timestamps
    end
    rename_column :orders_products, :number_product, :count
  end
end
