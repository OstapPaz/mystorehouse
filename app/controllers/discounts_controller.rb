class DiscountsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_admin_checker

  def index
    @discount = Discount.new
    @discounts = Discount.all
  end

  def create
    @discount = Discount.create!(discount_params)
    redirect_to discounts_path
  end

  def show
    @discount = Discount.find(params[:id])
  end

  def update
    old_discount = Discount.find(params[:id])
    old_discount.update(discount_params)
    redirect_to discounts_path
  end

  private

  def discount_params
    params.require(:discount).permit(:name, :criterion, :criterion_second)
  end



end
