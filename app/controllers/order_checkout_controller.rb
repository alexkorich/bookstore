class OrderCheckoutController < ApplicationController
 include Wicked::Wizard

  steps :adress, :delivery, :payment, :confirm, :complete

  def show
    @order=current_user.current_order

  case step
    when :adress
      @billing_adress = current_user.current_order.billing_adress || Adress.new
    when :delivery
      @delivery = current_user.current_order.delivery || Delivery.first
    when :payment
      @credit_card = @order.credit_card || CreditCard.new
    when :confirm
    @credit_card = @order.credit_card || CreditCard.new
    
    when :complete
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
      @credit_card = @order.credit_card || CreditCard.new(credit_card_attributes)
      if @credit_card.save
      render_wizard @order
      return
      else
        render_wizard
      end
    when :confirm
      @order.state = :in_queue
      @order.completed_at = Time.current
      if @order.save
      return render_wizard @order
      end
      when :complete
      render_wizard @order
  
  end
  end
  


  def billing_adress_attributes
    params.require(:billing_adress).permit(:firstname, :lastname,:street,:city, :country, :zipcode, :phone)
  end

  def credit_card_attributes
    params.require(:credit_card).permit(:number, :cvv, :expiration_year, :expiration_month, :firstname, :lastname)
  end
end