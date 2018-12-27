class Order < ApplicationRecord
  has_many :orders_products
  has_many :products, :through => :orders_products
  belongs_to :user, optional: true

  def self.new_from_cart(cart)
    order = self.new

    cart['products'].each do |product|
      order.orders_products << OrdersProduct.new(product_id: product['product_id'], count: product['count'])
    end

    order
  end

  def add_cart(cart)
    cart['products'].each do |product|
      orders_products << OrdersProduct.new(product_id: product['product_id'], count: product['count'])
    end
    self.price = price
    self
  end

  def price
    orders_products.sum(0) { |order_product| order_product.product.price * order_product.count }
  end

end
