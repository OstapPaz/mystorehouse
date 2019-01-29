class Admin::BaseController < ApplicationController

  before_action :user_admin_checker

  def admin_home
  end

  private

  def user_admin_checker
    redirect_to root_path unless current_user.present? && current_user.admin_permission
  end

end