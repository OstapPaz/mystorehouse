class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :customer_contacts
  has_one :cart
  has_many :cart_items, through: :cart
  has_many :orders
  has_many :comments, dependent: :destroy
  validates :name, :email, presence: true
  ratyrate_rater

end
