require 'rufus/scheduler'
scheduler = Rufus::Scheduler.start_new

if Rails.env.production?
  # workaround to keep our app awake on Heroku
  scheduler.every '10m' do
     require "net/http"
     require "uri"
     logger.info "# Waking up Heroku scheduler"
     Net::HTTP.get_response(URI.parse(ENV["MWD_HOSTNAME"]))
  end

  # scheduler to reminder users to save activity of previous day
  # it runs every day at noon
  scheduler.cron("0 12 * * *") do
    logger.info "## Sending email reminders"
    User.all_want_receive_mail_notification.each do |user|
      UserMailer.activity_reminder(user).deliver
      logger.info "### Sent email to #{user.name} <#{user.email}>"
    end
  end
end