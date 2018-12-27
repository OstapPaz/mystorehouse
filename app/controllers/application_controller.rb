class ApplicationController < ActionController::Base
  def cart
    if session['cart']['products'].present?
      session['cart']
    else
      session['cart'] = { 'products' => [] }
    end
  end

  def add_prod_to_cart(product_id, number)
    cart['products'] << { 'product_id' => product_id, 'count' => number }
  end
end
