class Order < ApplicationRecord
  has_many :products
  belongs_to :contact_customer
  validates
end
