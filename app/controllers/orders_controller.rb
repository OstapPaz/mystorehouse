class OrdersController < ApplicationController

  before_action :authenticate_user!, only: [:index, :change_status, :destroy]

  def new
    @order = Order.new
    @order.orders_products.build
    @discount_price = DiscountService.new(cart, price_without_discount).discount_price

    respond_to do |format|
      format.html
      format.json { render json: { data: @discount_price } }
    end
  end

  def create
    @order = Order.new(order_params)
    @order.price = DiscountService.new(cart, price_without_discount).discount_price
    @order.user_id = current_user.id if current_user.present?
    if @order.save
      save_functionality
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
    params.require(:order).permit(:name_customer, :contact_phone_number, :address, orders_products_attributes: [ :amount, :product_id ])
  end

  def save_functionality
    Resque.enqueue(MailSender, current_user, @order)
    flash[:info] = "Order created"
    cart.destroy
    redirect_to orders_path
  end

end