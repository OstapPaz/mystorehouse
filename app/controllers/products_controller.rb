class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :user_admin_checker, only: [:new, :create, :edit, :update, :destroy]
  after_action :product_avatar, only:[:create]

  # GET /products
  # GET /products.json
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


  # GET /products/1
  # GET /products/1.json
  def show
    @comments = @product.comments || []
    @comment = Comment.new
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :model, :price, :category_id, :avatar)
  end

  def product_avatar
    @product.check_avatar
  end

end
