class RemoveRatingFieldInComments < ActiveRecord::Migration[5.2]
  def change
    remove_column :comments, :rating
  end
end
