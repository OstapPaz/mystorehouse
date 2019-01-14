class ProductItemInCart < ApplicationRecord

  belongs_to :product

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :product_present

end
