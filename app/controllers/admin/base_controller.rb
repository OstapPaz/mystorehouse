class Admin::BaseController < ApplicationController

  before_action :user_admin_checker

end