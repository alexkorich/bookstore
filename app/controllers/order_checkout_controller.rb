class OrderCheckoutController < ApplicationController
 include Wicked::Wizard

  steps :adress, :delivery, :payment, :confirm, :complete

  def show
    @user = current_user
    case step
    when :adress
      @friends = @user.find_friends
    end
  when :delivery
      @friends = @user.find_friends
    end
    when :payment
      @friends = @user.find_friends
    end

    render_wizard
  end
end
