ActionMailer::Base.smtp_settings = {
  address:              'smtp.gmail.com',
  port:                 587,
  domain:               ENV['MWD_HOSTNAME'],
  user_name:            ENV['MWD_MAIL_USERNAME'],
  password:             ENV['MWD_MAIL_PASSWORD'],
  authentication:       'plain',
  enable_starttls_auto: true  
}

ActionMailer::Base.default_url_options[:host] = ENV['MWD_HOSTNAME']