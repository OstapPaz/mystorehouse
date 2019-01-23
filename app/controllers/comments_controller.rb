class CommentsController < ApplicationController
  before_action :authenticate_user!, :set_product

  def create
    @comment = Comment.create! comment_params
    redirect_back fallback_location: products_path
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :user_id, :product_id)
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

end
