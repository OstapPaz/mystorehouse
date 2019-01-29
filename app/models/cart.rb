class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_items
  has_many :products, through: :cart_items

  def add_cart_item(product_id, quantity)
    cart_items << CartItem.new(product_id: product_id, quantity: quantity)
  end

  def update_cart_from_order(order_items)
    order_items.each do |order_item|
      change_amount_of_product(order_item['product_id'], order_item['amount'])
    end
  end

  private

  def change_amount_of_product(product_id, amount)
    cart_items.where(product_id: product_id).first.update_attribute(:quantity, amount)
  end
end