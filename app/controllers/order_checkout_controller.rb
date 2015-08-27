class OrderCheckoutController < ApplicationController
 include Wicked::Wizard

  steps :adress, :delivery, :payment, :confirm, :complete

  def show
    @user = current_user
    case step
    when :adress
      @adress = current_user.current_order.billing_adress
    
  when :delivery
      @friends = @user.find_friends
    
    when :payment
      @friends = @user.find_friends
    
  end
    render_wizard
  end
end
