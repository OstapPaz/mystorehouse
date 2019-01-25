class DiscountService


  def initialize(cart, price)
    @products = cart.products
    @price = price
  end

  def discount_price
    if @products.count > number_all_products.criterion
      disc_price = @price - @price * number_all_products.criterion_second *
          (@products.count - number_all_products.criterion)
    elsif discount_category?
      disc_price = @price - category_products_discount
    elsif @price > price_board.criterion
      disc_price = @price - @price * price_board.criterion_second
    else
      disc_price = @price
    end

    disc_price
  end

  private

  def category_products_discount
    category_discount = 0
      Category.all.each do |category|
        category_discount +=  @products.find { |product| product.category.name == category.name }.sum(:price) *
            same_category.second_criterion
      end
    category_discount
  end

  def discount_category?
    checker = false
    Category.all.each do |category|
       if @products.count { |product| product.category.name == category.name } > same_category.criterion
         checker = true
       end
    end
    checker
  end

  def same_category #discount on products for same category
    Discount.find_by(name: 'same category')
  end

  def number_all_products #discount on number of all products
    Discount.find_by(name: 'number of all products')
  end

  def price_board
    Discount.find_by(name: 'price board')
  end

end