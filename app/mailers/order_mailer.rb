class OrderMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def order_email
    @user = params[:user]
    @order = params[:order]
    mail(to: @user.email, subject: 'Your new order')
  end
end
