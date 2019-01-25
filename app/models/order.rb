class Order < ApplicationRecord
  include AASM

  has_many :orders_products
  accepts_nested_attributes_for :orders_products
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
    update(status: status)
  end

end
