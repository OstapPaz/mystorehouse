class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|

      t.string :name
      t.string :text
      t.string :contact
      t.bigint :user_id

      t.timestamps
    end
  end
end
