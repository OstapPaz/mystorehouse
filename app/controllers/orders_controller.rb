class OrdersController < ApplicationController

  before_action :user_signed_in?, only: [:index]

  def new
    @order = Order.new_from_cart(cart)
    @discount_price = DiscountService.new(cart['products'], @order.price).discount_price
  end

  def remove_from_cart
    cart['products'].delete_if { |h| h["product_id"] == params[:remove_product_id] }
    respond_to do |format|
      format.html { redirect_to new_order_path, notice: 'Product was successfully deleted from cart.' }
    end
  end

  def create
    @order = Order.new(order_params).add_cart(cart)
    @order.user_id = current_user.id if current_user.present?
    @order.price = DiscountService.new(cart['products'], @order.price).discount_price

    if @order.save
      flash[:info] = "Order created"
      session['cart'] = { 'products' => [] }
      redirect_to orders_path
    else
      render 'new'
    end

  end

  def index
    @orders = Order.where(user_id: current_user.id)
  end

  def update_cart
    Cart.update(cart, params['products'])
    redirect_back fallback_location: new_order_path
  end

  private

  def order_params
    params.require(:order).permit(:name_customer, :contact_phone_number, :address)
  end


end
