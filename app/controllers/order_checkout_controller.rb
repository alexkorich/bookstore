class OrderCheckoutController < ApplicationController
 include Wicked::Wizard

  steps :adress, :delivery, :payment, :confirm, :complete

  def show
    @order=current_user.current_order

  case step
    when :adress
      @billing_adress = current_user.current_order.billing_adress
    when :delivery
      @delivery = current_user.current_order.delivery
    when :payment
      @card = @order.credit_card
  end
    render_wizard
  end

  def update
    @order=current_user.current_order
  case step
   when :adress
    @order.billing_adress=@order.billing_adress || Adress.new(billing_adress_attributes)
    if @order.billing_adress.save
      render_wizard @order
      return
    else
      render_wizard
    end
  when :delivery
      @order.delivery = @order.delivery || Delivery.find(params[:order][:delivery])
      if @order.delivery.save
      render_wizard @order
      return
    else
      render_wizard
    end
    when :payment
      @card = @order.credit_card
  end
    render_wizard

  end


  def billing_adress_attributes
    params.require(:billing_adress).permit(:firstname, :lastname,:street,:city, :country, :zipcode, :phone)
  end
end