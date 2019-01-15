class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :order_price, :current_user, :admin?, :cart
  before_action :guest_session, only: [:cart]

=begin
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
=end

  def cart
    if current_user.nil?
      guest_session if session[:guest_session].nil?
      if cart = Cart.find_by(session_id: session[:guest_session])
        cart
      else
        Cart.create!(session_id: session[:guest_session])
      end
    else
      if current_user.cart.present?
        current_user.cart
      else
        current_user.cart = Cart.create!
      end
    end
  end

  def order_price
    cart.order_price
  end

  def add_prod_to_cart(product_id, number)
    cart.add_cart_item(product_id, number)
  end


  def user_admin_checker
    redirect_to root_path unless current_user.admin_permission
  end

  def admin?
    current_user.admin_permission if current_user.present?
  end

  def guest_session
    session[:guest_session] = CartService.generate_id if session[:guest_session].nil?
    session[:guest_session]
  end

end
