ActionMailer::Base.smtp_settings = {
  :address => "smtp.gmail.com",
  :port  => 587,
  :domain  => 'bookstore-korich.herokuapp.com',
  :user_name => "boostore.delivery@gmail.com",
  :password => "bbb111111",
  :authentication => 'plain',
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "bookstore-korich.herokuapp.com"