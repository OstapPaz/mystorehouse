class Product < ApplicationRecord
  has_many :order_product
  has_many :orders, :through => :order_product
  belongs_to :category
end
