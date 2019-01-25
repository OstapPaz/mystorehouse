class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_items
  has_many :products, through: :cart_items

  def add_cart_item(product_id, quantity)
    cart_items << CartItem.new(product_id: product_id, quantity: quantity)
  end


end