class CartService

  def self.generate_id
    if Cart.last.present?
      Cart.last.session_id + 1
    else
      1
    end
  end

end