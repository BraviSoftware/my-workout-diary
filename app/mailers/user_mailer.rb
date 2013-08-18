class UserMailer < ActionMailer::Base
  default from: ENV['MWD_MAIL_USERNAME']

  def activity_reminder
    @greeting = "Hi"

    mail to: "maxcnunes@gmail.com"

    puts "------- sent email ----------"
  end
end
