class OrdersController < ApplicationController

  before_action :authenticate_user!, only: [:index, :change_status, :destroy]
  helper_method :price_without_discount

  def new
    @order = Order.new
    @order.orders_products.build
    @discount_price = discount_price

    respond_to do |format|
      format.html
      format.json { render json: { data: @discount_price } }
    end
  end

  def create
    @order = Order.new(order_params)
    cart.update_cart_from_order(@order.orders_products)
    @order.price = discount_price
    @order.user_id = current_user.id if current_user.present?
    if @order.save
      Resque.enqueue(MailSender, current_user, @order)
      flash[:info] = 'Order created'
      cart.destroy
      redirect_to orders_path
    else
      render 'new'
    end
  end

  def index
    @orders = admin? ? Order.all : Order.where(user_id: current_user.id)
  end

  def show
    @ord = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:name_customer, :contact_phone_number,
                                  :address, orders_products_attributes: [ :amount, :product_id ])
  end

  def discount_price
    DiscountService.new(cart).discount_price
  end

  def price_without_discount
    DiscountService.new(cart).price_without_discount
  end

end