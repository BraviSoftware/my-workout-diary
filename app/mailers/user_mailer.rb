class UserMailer < ActionMailer::Base
  default from: ENV['MWD_MAIL_USERNAME']

  def activity_reminder(user)
    @user = user
    @user.email_exercise_token = SecureRandom.uuid
    @user.save

    mail to: @user.email
  end
end