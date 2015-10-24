class OrderCheckoutController < ApplicationController
 include Wicked::Wizard

  steps :adress, :delivery, :payment, :confirm, :complete

  def show
    @order=current_user.current_order
    @id=@order.id
  case step
    when :adress
      @billing_adress = @order.billing_adress || Adress.new
      @shipping_adress = @order.shipping_adress || Adress.new
    when :delivery
      @delivery = @order.delivery || Delivery.first
    when :payment
      @credit_card = @order.credit_card || CreditCard.new
    when :confirm
      @credit_card = @order.credit_card
      @billing_adress = @order.billing_adress
      @shipping_adress = @order.shipping_adress
      @delivery = @order.delivery

    when :complete
      @order1=Order.find(@id)
       @credit_card = @order1.credit_card
      @billing_adress = @order1.billing_adress
      @shipping_adress = @order1.shipping_adress
      @delivery = @order1.delivery
    end
    render_wizard
  end

  def update
    @order=current_user.current_order
  case step
   when :adress
    if  @order.billing_adress && @order.shipping_adress

      @order.billing_adress.update_attributes(billing_adress_attributes)
      @order.shipping_adress.update_attributes(shipping_adress_attributes)
      if request.params["useBilling?"]==["true"]
        @order.billing_adress.update_attributes(billing_adress_attributes)
        @order.shipping_adress.update_attributes(billing_adress_attributes)
      elsif request.params["useBilling?"]==["false"]
        @order.billing_adress.update_attributes(billing_adress_attributes)
        @order.shipping_adress.update_attributes(shipping_adress_attributes)
      end



    else
      if request.params["useBilling?"]==["true"]
        @order.billing_adress= Adress.new(billing_adress_attributes)
        @order.shipping_adress= Adress.new(billing_adress_attributes)
      elsif request.params["useBilling?"]==["false"]
        @order.billing_adress=Adress.new(billing_adress_attributes)
        @order.shipping_adress=Adress.new(shipping_adress_attributes)
      end


      end
      if @order.billing_adress.save && @order.shipping_adress.save
        render_wizard @order
        return
      else
        flash[:notice] = @order.billing_adress.errors.full_messages+["XX"]+@order.shipping_adress.errors.full_messages
        render_wizard
      end
    when :delivery
      if @order.delivery 
        @order.delivery=Delivery.find(params[:delivery])
      else
        @order.delivery =Delivery.find(params[:delivery])
      end
       
      if @order.delivery.save
        render_wizard @order
        return
      else
        flash[:notice] = @order.errors.full_messages
        render_wizard
      end
    when :payment
      if @order.credit_card
        @order.credit_card.update_attributes(credit_card_attributes)
      else
         @order.credit_card= CreditCard.new(credit_card_attributes)
      end  
     
      if @order.credit_card.save
      render_wizard @order
      return
      else
        flash[:notice] = @order.credit_card.errors.full_messages
        render_wizard
      end
    when :confirm
      @order.pay
      @order.completed_date = Time.current

      if @order.save
      render_wizard @order

      return 
        else redirect_to '/'
      end
      when :complete
        2
      render_wizard @order
  
  end
  end
  


  def billing_adress_attributes
    params.require(:billing_adress).permit(:firstname, :lastname,:street, :adress, :city, :country_id, :zipcode, :phone)
  end
  def shipping_adress_attributes
    params.require(:shipping_adress).permit(:firstname, :lastname,:street,:city, :country_id, :adress, :zipcode, :phone)
  end

  def credit_card_attributes
    params.require(:credit_card).permit(:number, :cvv, :expiration_year, :expiration_month, :firstname, :lastname)
  end
end