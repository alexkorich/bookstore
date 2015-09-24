class UserMailer < ApplicationMailer
  def delivery(user)




  end
  def payment(user)
  end

  def registered(user)
    @user = user
  mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

end
