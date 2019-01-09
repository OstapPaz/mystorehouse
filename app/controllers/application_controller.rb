class ApplicationController < ActionController::Base
  def cart
    if session['cart'].present? && session['cart']['products'].present?
      session['cart']
    else
      session['cart'] = { 'products' => [] }
    end
  end

  def add_prod_to_cart(product_id, number)
    cart['products'] << { 'product_id' => product_id, 'count' => number}
  end

  def order_price
    if session['order_price'].present?
      session['order_price']
    else
      session['order_price'] = 0
    end
  end

  def user_admin?
    redirect_to root_path unless current_user.admin_permission
  end

  def user_signed_checker
    redirect_to root_path unless user_signed_in?
  end

  helper_method :order_price, :current_user
end
