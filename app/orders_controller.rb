class OrdersController < ApplicationController

  def create 
    @order = Order.new(params[:order])
    @order.user = current_user
    if @order.save
      if c = @order.charge!
        Notifier.charged(c).deliver
        redirect_to order_path(@order)
      else
        @order.destroy
        render 'new' 
      end
    else
      render 'new'
    end
  end
end
