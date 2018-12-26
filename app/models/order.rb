class Order < ApplicationRecord
  has_many :order_product
  has_many :product, :through => :order_product
  belongs_to :user
end
