class Admin::DiscountsController < Admin::BaseController

  def index
    @discount = Discount.new
    @discounts = Discount.all
  end

  def create
    @discount = Discount.create!(discount_params)
    redirect_to admin_discounts_path
  end

  def show
    discount
  end

  def update
    discount.update(discount_params)
    redirect_to admin_discounts_path
  end

  private

  def discount_params
    params.require(:discount).permit(:name, :criterion, :criterion_second)
  end

  def discount
    @discount ||= Discount.find(params[:id])
  end
  helper_method :discount

end
