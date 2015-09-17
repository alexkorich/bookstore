class OrderCheckoutController < ApplicationController
 include Wicked::Wizard

  steps :adress, :delivery, :payment, :confirm, :complete




  def show
    @user = current_user
    @order=@user.current_order

  case step
    when :adress
      @adress = current_user.current_order.billing_adress
    
  when :delivery
      @delivery = current_user.current_order.delivery
    
    when :payment
      @friends = @user.find_friends
    
  end
    render_wizard
  end

  def update
    @user = current_user
    @order=@user.current_order
   when :adress
      @adress = current_user.current_order.billing_adress
    
  when :delivery
      @delivery = current_user.current_order.delivery
    
    when :payment
      @friends = @user.find_friends
    
  end
    render_wizard

end
