class EditOrder < ActiveRecord::Migration[5.2]
  def change
    rename_table :contact_customers, :customer_contacts
    change_table :orders do |t|
      t.remove :contact_customer_id
      t.string :name_customer
      t.string :contact_phone_number
      t.string :address
    end

  end
end
