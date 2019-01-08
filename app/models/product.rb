class Product < ApplicationRecord
  include Filterable

  has_many :orders_products
  has_many :orders, :through => :orders_products
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_one_attached :avatar

  def show_rating
    return comments.sum(:rating) / comments.count if comments.present?
    0
  end

  def check_avatar
    default_image = '/home/opazyniuk/Downloads/question_top.jpg'
    avatar.attach(io: File.open(default_image), filename: 'question_top.jpg', content_type: 'image/png') if avatar.nil?
  end


end
