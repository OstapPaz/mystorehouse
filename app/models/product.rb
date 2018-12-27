class Product < ApplicationRecord
  has_many :orders_products
  has_many :orders, :through => :orders_products
  belongs_to :category
  has_many :comments, dependent: :destroy

  def show_rating
    return comments.sum(:rating) / comments.count if comments.present?
    0
  end

end
