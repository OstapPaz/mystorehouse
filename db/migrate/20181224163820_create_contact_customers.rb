class CreateContactCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_customers do |t|

      t.string :address
      t.string :contact_number
      t.belongs_to :user
      t.timestamps
    end

    change_table :orders do |t|
      t.remove :user_id
      t.string
      t.belongs_to :contact_customer
    end


    create_join_table :products, :orders do |t|
      t.show [:product_id, :order_id]
    end


  end
end
