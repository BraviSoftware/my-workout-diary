require 'rufus/scheduler'
scheduler = Rufus::Scheduler.start_new

if Rails.env.production?
  scheduler.every '10m' do
     require "net/http"
     require "uri"
     puts "### Waking up Heroku scheduler at #{Time.now}"
     Net::HTTP.get_response(URI.parse(ENV["MWD_HOSTNAME"]))
     UserMailer.activity_reminder.deliver
  end
end