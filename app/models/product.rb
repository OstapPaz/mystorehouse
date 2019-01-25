class Product < ApplicationRecord

  has_many :orders_products
  has_many :orders, through: :orders_products
  belongs_to :category
  has_many :cart_items
  has_many :comments, dependent: :destroy
  has_one_attached :avatar
  ratyrate_rateable 'quality'
  before_create :check_avatar

  filterrific(
      default_filter_params: { sorted_by: 'created_at_desc' },
      available_filters: [
       :sorted_by,
       :search_query,
       :with_category_id,
    ]
  )

  scope :search_query, ->(query) {
    return nil  if query.blank?
    terms = query.downcase.split(/\s+/)

    terms = terms.map { |e|
      (e.tr("*", "%") + "%").gsub(/%+/, "%")
    }

    num_or_conds = 3
    where(
        terms.map { |_term|
          "(LOWER(products.name) LIKE ? OR LOWER(products.model) LIKE ? OR LOWER(products.adding_information) LIKE ?)"
        }.join(" AND "),
        *terms.map { |e| [e] * num_or_conds }.flatten,
        )
  }

  scope :sorted_by, ->(sort_option) {
    direction = /desc$/.match?(sort_option) ? "desc" : "asc"
    case sort_option.to_s
    when /^created_at_/
      order("products.created_at #{direction}")
    when /^name_/
      order("LOWER(products.name) #{direction}, LOWER(products.model) #{direction},
                                       LOWER(products.adding_information) #{direction}")
    when /^category_name_/
      order("LOWER(categories.name) #{direction}").includes(:category).references(:category)
    else
      raise(ArgumentError, "Invalid sort option: #{sort_option.inspect}")
    end
  }

  scope :with_category_id, ->(category_ids) {
    where(category_id: [*category_ids])
  }

  def check_avatar
    #default_image = '/home/opazyniuk/Downloads/question_top.jpg'
    default_image = Rails.root + 'app' + 'assets' + 'images' + 'question_top.jpg'
    unless avatar.attached?
      avatar.attach(io: File.open(default_image), filename: 'default', content_type: 'image/jpeg')
    end
  end

  def self.options_for_sorted_by
    [
        ["Name (a-z)", "name_asc"],
        ["Registration date (newest first)", "created_at_desc"],
        ["Registration date (oldest first)", "created_at_asc"],
    ]
  end


end
