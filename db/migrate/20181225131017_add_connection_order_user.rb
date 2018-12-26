class AddConnectionOrderUser < ActiveRecord::Migration[5.2]
  def change
    change_table :orders do |t|
      t.belongs_to :user, index: true
    end

    remove_column :products, :category

    change_table :products do |t|
      t.belongs_to :category
    end
  end
end
