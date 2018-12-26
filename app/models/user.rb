class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :customer_contacts
  has_many :orders
  validates :name, :email, :phone_number, presence: true

  def admin?
    self.admin_permission
  end
end
