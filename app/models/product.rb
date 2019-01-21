class Product < ApplicationRecord
  include Filterable

  has_many :orders_products
  has_many :orders, through: :orders_products
  belongs_to :category
  has_many :cart_items
  has_many :comments, dependent: :destroy
  has_one_attached :avatar
  ratyrate_rateable 'quality'
  before_create :check_avatar

  def show_rating
    return comments.sum(:rating) / comments.count if comments.present?
    0
  end

  def check_avatar
    default_image = '/home/opazyniuk/Downloads/question_top.jpg'
    unless avatar.attached?
      avatar.attach(io: File.open(default_image), filename: 'default', content_type: 'image/jpeg')
    end
  end


end
