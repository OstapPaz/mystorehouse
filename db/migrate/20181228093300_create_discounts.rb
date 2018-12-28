class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|

      t.string :name, null: false
      t.decimal :criterion, null: false
      t.decimal :criterion_second

      t.timestamps
    end
  end
end
