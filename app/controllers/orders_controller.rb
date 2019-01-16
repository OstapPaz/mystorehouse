class OrdersController < ApplicationController

  before_action :authenticate_user!, only: [:index, :change_status, :index_all, :destroy]
  before_action :user_admin_checker, only: [:index_all, :change_status, :destroy]

  def new
    @order = Order.new_from_cart(cart)
    @discount_price = DiscountService.new(cart, @order.price_current).discount_price
  end

  def remove_from_cart
    cart.cart_items.where(product_id: params[:remove_product_id]).each { |p| p.destroy }
    respond_to do |format|
      format.html { redirect_to new_order_path, notice: 'Product was successfully deleted from cart.' }
    end
  end

  def create
    @order = Order.new(order_params).add_cart(cart)
    @order.user_id = current_user.id if current_user.present?
    @order.price = DiscountService.new(cart, @order.price_current).discount_price
    if @order.save
      Resque.enqueue(MailSender, current_user, @order)
      #MailSender.perform_later(current_user, @order) -
      #OrderMailer.order_email(current_user, @order).deliver +
      flash[:info] = "Order created"
      cart.destroy
      redirect_to orders_path
    else
      render 'new'
    end
  end

  def index
    @orders = Order.where(user_id: current_user.id)
  end

  def index_all
    @orders = Order.all
  end

  def update_cart
    Cart.update(cart, params['products'])
    redirect_back fallback_location: new_order_path
  end

  def change_status
    Order.find(params[:id]).change_order_status
    redirect_to order_all_path
  end

  def show
    @ord = Order.find(params[:id])
  end

  def destroy
    Order.destroy(params[:id])
    redirect_to order_all_path
  end

  private

  def order_params
    params.require(:order).permit(:name_customer, :contact_phone_number, :address)
  end

end