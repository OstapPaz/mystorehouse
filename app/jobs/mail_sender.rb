class MailSender
  @queue = :file_serve

  def self.perform(user, order)
    OrderMailer.order_email(user, order).deliver
  end
end