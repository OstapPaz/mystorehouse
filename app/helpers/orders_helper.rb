module OrdersHelper

  def default_name
    current_user.try(:name) || 'Dmytro'
  end

  def default_number
    current_user.customer_contacts.try(:contact_number) || '123 456 789'
  end

  def default_address
    current_user.customer_contacts.try(:address) || 'Gotham'
  end


end
