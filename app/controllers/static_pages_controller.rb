class StaticPagesController < ApplicationController

  before_action :user_admin_checker, only: [:admin_home]

  def home
  end

  def admin_home
  end

  def contact
  end


end
