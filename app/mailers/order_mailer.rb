class OrderMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def order_email(user, order)
    @user = user
    @order = order
    mail(to: @user['email'], subject: 'Order email')
  end
end
