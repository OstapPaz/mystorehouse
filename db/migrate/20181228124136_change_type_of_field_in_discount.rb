class ChangeTypeOfFieldInDiscount < ActiveRecord::Migration[5.2]
  def change
    change_column :discounts, :criterion_second, :float
  end
end
