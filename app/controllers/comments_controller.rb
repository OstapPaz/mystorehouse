class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_back fallback_location: products_path
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:text, :rating, :user_id, :product_id)
  end

end
