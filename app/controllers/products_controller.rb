class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  def index
    @filterrific = initialize_filterrific(
        Product,
        params[:filterrific],
        select_options: {
            sorted_by: Product.options_for_sorted_by,
            with_category_id: Category.options_for_select,
        },
        persistence_id: "shared_key",
        default_filter_params: { },
        available_filters: [:sorted_by, :with_category_id, :search_query],
        sanitize_params: true,
        ) || return
    @products = @filterrific.find.page(params[:page]).per_page(12)

    respond_to do |format|
      format.html
      format.js
    end

  rescue ActiveRecord::RecordNotFound => e
    puts "Had to reset filterrific params: #{e.message}"
    redirect_to(reset_filterrific_url(format: :html)) && return
  end

  def show
    @comments = @product.comments || []
    @comment = Comment.new
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

end
