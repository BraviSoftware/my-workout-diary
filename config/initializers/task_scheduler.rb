require 'rufus/scheduler'
scheduler = Rufus::Scheduler.start_new

if Rails.env.production?
  # workaround to keep our app awake on Heroku
  scheduler.every '10m' do
     require "net/http"
     require "uri"
     puts "### Waking up Heroku scheduler at #{Time.now}"
     Net::HTTP.get_response(URI.parse(ENV["MWD_HOSTNAME"]))
  end

  # scheduler to reminder users to save activity of previous day
  # it runs every day at noon
  scheduler.cron("0 12 * * *") do
    User.all_want_receive_mail_notification.each do |user|
     UserMailer.activity_reminder(user).deliver
    end
  end
end