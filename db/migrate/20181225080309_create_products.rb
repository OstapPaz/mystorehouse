class CreateProducts < ActiveRecord::Migration[5.2]
  def change

    drop_table :products

    create_table :products do |t|

      t.string :name, null: false
      t.string :category, null: false
      t.string :model, null: false
      t.string :adding_information
      t.timestamps
    end
  end
end
