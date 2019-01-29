class CartService

  def initialize(current_user, session)
    @user = current_user
    @session = session
  end

  def cart
    if @user.nil?
      cart_without_user
    else
      cart_with_user
    end
  end

  def guest_session
    if @session[:guest_session].present?
      @session[:guest_session]
    else
      @session[:guest_session] = SecureRandom.uuid
    end
  end

  def cart_with_user
    if @user.cart.present?
      @user.cart
    else
      @user.cart = Cart.create!
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