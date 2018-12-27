class Cart

  def self.update(cart, products)
    products.each do |product_id, count|
      cart_product = cart['products'].find { |cp| cp['product_id'] == product_id }
      cart_product['count'] = count
    end
  end

end