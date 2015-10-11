class UserMailer < ApplicationMailer
  def delivery(user, order)
    @user=user
    @order=order
    mail(to: @user.email, subject: "Order #{@order.id} in delivery")


  end
  def payment(user)
  end

  def registered(user)
    @user = user
  mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
  def pay(user, order)
     @user=user
    @order=order
    mail(to: @user.email, subject: "Order confirmation")


  end
end
