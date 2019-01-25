class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :price_without_discount, :current_user, :admin?, :cart

  def cart
    if current_user.nil?
      cart_without_user
    else
      cart_with_user
    end
  end

  def price_without_discount
    cart.cart_items.sum(0) { |order_product| order_product.product.price * order_product.quantity.to_i }
  end

  def user_admin_checker
    redirect_to root_path unless current_user.present? && current_user.admin_permission
  end

  def admin?
    current_user.admin_permission if current_user.present?
  end

  private

  def guest_session
    if session[:guest_session].present?
      session[:guest_session]
    else
      session[:guest_session] = SecureRandom.uuid
    end
  end

  def cart_with_user
    if current_user.cart.present?
      current_user.cart
    else
      current_user.cart = Cart.create!
    end
  end

  def cart_without_user
    if cart = Cart.find_by(session_id: guest_session)
      cart
    else
      Cart.create!(session_id: guest_session)
    end
  end

end
