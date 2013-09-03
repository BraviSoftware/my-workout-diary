class UserMailer < ActionMailer::Base
  default from: ENV['MWD_MAIL_USERNAME']

  def activity_reminder(user)
    @user = user
    @activity_types = ActivityType.all_not_done_by_user_yesterday(@user)

    # prevent send notificaiton if there isn't activity types available to mark
    return false unless @activity_types.size > 0

    @user.generate_email_notification_token
    @yesterday = Date.today.prev_day
    mail to: @user.email 
  end
end