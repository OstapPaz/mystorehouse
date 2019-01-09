class CustomerContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :customer_contacts_checker, only: [:show]

  def show
    @customer_contacts = current_user.customer_contacts
  end

  def update
    if current_user.customer_contacts.update(customer_contacts_params)
      flash[:info] = "Customer contacts updated"
      redirect_to root_path
    else
      render 'show'
    end
  end

  private

  def customer_contacts_params
    params.require(:customer_contacts).permit(:address, :contact_number)
  end

  def customer_contacts_checker
    current_user.customer_contacts = CustomerContacts.new if current_user.customer_contacts.nil?
  end

end
