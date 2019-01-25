class CartsController < ApplicationController

  def add_to_cart
    add_prod_to_cart(params[:id], params[:num].to_i)
    respond_to do |format|
      format.html { redirect_to products_path, notice: 'Product was successfully added to cart.' }
    end
  end


  def remove_from_cart
    cart.cart_items.where(product_id: params[:remove_product_id]).first.destroy
    respond_to do |format|
      format.html { redirect_to new_order_path, notice: 'Product was successfully deleted from cart.' }
    end
  end

  private

  def add_prod_to_cart(product_id, number)
    cart.add_cart_item(product_id, number)
  end



end
