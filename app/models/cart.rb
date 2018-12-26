class Cart

  attr_accessor :products

  def add_product(prod_id)
    :products << prod_id
  end

end