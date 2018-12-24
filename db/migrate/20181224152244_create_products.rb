class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|

      t.text :name, null: false
      t.integer :price, null: false
      t.string :model
      t.string :country
      t.string :type, index: true, null: false
      t.timestamps
    end
  end
end
