ActionMailer::Base.smtp_settings = {
  address: "smtp.gmail.com",
  port: 587,
  domain: ENV["MAILER_DOMAIN"],
  user_name: ENV["MAILER_USER_NAME"],
  password: ENV["MAILER_PASSWORD"],
  authentication: 'plain',
  enable_starttls_auto: true
}

ActionMailer::Base.default_url_options[:host] = "bookstore-korich.herokuapp.com"
