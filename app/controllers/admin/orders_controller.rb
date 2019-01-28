class Admin::OrdersController < Admin::BaseController

  def change_status
    Order.find(params[:id]).change_order_status
    redirect_to orders_path
  end

  def destroy
    Order.destroy(params[:id])
    redirect_to orders_path
  end

end