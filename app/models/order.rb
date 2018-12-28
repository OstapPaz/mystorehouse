class Order < ApplicationRecord
  include AASM

  has_many :orders_products
  has_many :products, :through => :orders_products
  belongs_to :user, optional: true

  aasm column: 'status' do
    state :new, initial: true
    state :confirmed
    state :paid
    state :send
    state :archived
    state :rejected

    event :confirm do
      transitions from: [:new], to: :confirmed
    end

    event :pay do
      transitions from: [:confirmed], to: :paid
    end

    event :sent do
      transitions from: [:paid], to: :send
    end

    event :archive do
      transitions from: [:new, :confirmed, :paid, :send], to: :archived
    end

    event :reject do
      transitions from: [:new, :confirmed, :send], to: :rejected
    end

  end

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

  def change_order
    if status == 'new'
      confirm
    elsif status == 'confirmed'
      pay
    elsif status == 'confirm'
      sent
    elsif status == 'send'
      archive
    elsif status == 'archived'
      reject
    else
      status = 'confirmed'
    end
    status
  end

end
