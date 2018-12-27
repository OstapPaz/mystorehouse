class Order < ApplicationRecord
  has_many :orders_products
  has_many :products, :through => :orders_products
  belongs_to :user

  def self.new_from_cart(cart)
    order = self.new

    cart['products'].each do |product|
      order.orders_products << OrdersProduct.new(product_id: product['product_id'], number_product: product['count'])
    end

    order
  end
end
