require 'rufus/scheduler'
scheduler = Rufus::Scheduler.start_new

if Rails.env.production?
  scheduler.every '10m' do
     require "net/http"
     require "uri"
     Net::HTTP.get_response(URI.parse(ENV["HOSTNAME"]))
  end
end