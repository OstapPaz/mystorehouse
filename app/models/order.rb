class Order < ApplicationRecord
  include AASM

  has_many :orders_products
  has_many :products, :through => :orders_products
  belongs_to :user, optional: true

  aasm column: 'status' do
    state :init, initial: true
    state :confirmed
    state :paid
    state :send
    state :archived
    state :rejected

    event :confirm do
      transitions from: [:init, :rejected], to: :confirmed
    end

    event :pay do
      transitions from: [:confirmed], to: :paid
    end

    event :sent do
      transitions from: [:paid], to: :send
    end

    event :archive do
      transitions from: [:init, :confirmed, :paid, :send], to: :archived
    end

    event :reject do
      transitions from: [:archived], to: :rejected
    end

  end

  def self.new_from_cart(cart)
    order = self.new

    cart['products'].each do |product|
      order.orders_products << OrdersProduct.new(product_id: product['product_id'], amount: product['count'])
    end

    order
  end

  def add_cart(cart)
    cart['products'].each do |product|
      orders_products << OrdersProduct.new(product_id: product['product_id'], amount: product['count'])
    end
    self.price = price_current
    self
  end

  def price_current
    orders_products.sum(0) { |order_product| order_product.product.price * order_product.amount.to_i }
  end

  def change_order_status
    if init?
      confirm
    elsif confirmed?
      pay
    elsif paid?
      sent
    elsif send?
      archive
    elsif archived?
      reject
    else
      confirm
    end
    self.update(status: self.status)
  end

end
