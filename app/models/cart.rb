class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_items
  has_many :products, through: :cart_items


  def self.update(cart, products)
    products.each do |product_id, amount|
      cart.cart_items.where(product_id: product_id).update(quantity: amount)
    end
  end

  def order_price
    cart_items.sum(&:total_price)
  end

  def add_cart_item(product_id, quantity)
    cart_items << CartItem.new(product_id: product_id, quantity: quantity)
  end


end