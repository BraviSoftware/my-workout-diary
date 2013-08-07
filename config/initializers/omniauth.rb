OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['MWD_FACEBOOK_APP_ID'], ENV['MWD_FACEBOOK_SECRET'], :scope => 'email'
end