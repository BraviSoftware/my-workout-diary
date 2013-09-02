class UserMailer < ActionMailer::Base
  default from: ENV['MWD_MAIL_USERNAME']

  def activity_reminder(user)
    @user = user
    @user.generate_email_notification_token

    @yesterday = Date.today.prev_day
    @ativity_types = ActivityType.all

    mail to: @user.email
  end
end