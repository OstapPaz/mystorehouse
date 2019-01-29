class ApplicationController < ActionController::Base
  PER_PAGE = 12

  protect_from_forgery with: :exception
  helper_method :current_user, :admin?, :cart

  def cart
    CartService.new(current_user, session).cart
  end

  def admin?
    current_user.try(:admin_permission)
  end

end
