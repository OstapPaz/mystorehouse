class OrdersController < ApplicationController

  def new
    # @customer = User.find(current_user.id)
    # @products = Product.where(id: cart['products'].map { |product| product['product_id']})
    @order = Order.new_from_cart(cart)
  end

  def remove_from_cart
    cart['products'].delete(:remove_product_id)
    respond_to do |format|
      format.html { redirect_to new_order_path, notice: 'Product was successfully deleted from cart.' }
    end
  end

end
