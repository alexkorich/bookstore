class OrderCheckoutController < ApplicationController
  authorize_resource :class => false
 include Wicked::Wizard 
  helper_method :step_index_for, :current_step_index, :wizard_path, :next_wizard_path
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
      @order=Order.where(user_id: current_user.id, state: "in_queue").order("updated_at").last
      @credit_card = @order.credit_card
      @billing_adress = @order.billing_adress
      @shipping_adress = @order.shipping_adress
      @delivery = @order.delivery

    end
    render_wizard
  end

  def update
    @order=current_user.current_order
    puts "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT"
    puts params
    k = step.to_s
    k = 'active' if step == :confirm
    @order.update_attributes(status: k)
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
      else
        @order.billing_adress=Adress.new(billing_adress_attributes)
        @order.shipping_adress=Adress.new(shipping_adress_attributes)
      end
      end
      if @order.billing_adress.save && @order.shipping_adress.save
        render_wizard @order
        return
      else
        flash.now[:notice] = @order.billing_adress.errors.full_messages+["XX"]+@order.shipping_adress.errors.full_messages
        render_wizard
      end
    when :delivery
      if @order.delivery 
        @order.delivery=Delivery.find(params[:delivery])
      elsif request.params["delivery"]
        @order.delivery =Delivery.find(params[:delivery])
      else 
        flash.now[:error] ="You need to chose correct delivery method. 1"
      end
      if @order.delivery
        if @order.delivery.save
        render_wizard @order
        return
      else
        flash.now[:notice] = @order.delivery.errors.full_messages
      end
    else
      flash.now[:error] ="You need to chose correct delivery method. 2"
    end
    render_wizard @order.delivery 
    when :payment
      if params["useExistingCard?"]
        @order.credit_card=CreditCard.find(params["card_id"])
      else
        if @order.credit_card
          @order.credit_card.update_attributes(credit_card_attributes)
        else
          @order.credit_card= CreditCard.new(credit_card_attributes)
        end  
      end
      if @order.credit_card.save
      render_wizard @order
      return
      else
        flash[:notice] = @order.credit_card.errors.full_messages
        render_wizard
      end
    when :confirm
      
      @order.completed_date = Time.current

      if @order.save
        @order.pay
      render_wizard @order
      return 
        else 
          flash[:notice] = @order.errors.full_messages
          render_wizard
      end
      when :complete
       
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
    params[:credit_card][:user_id]=current_user.id
    params.require(:credit_card).permit(:number, :cvv, :expiration_year, :expiration_month, :firstname, :lastname, :user_id)
  end

end