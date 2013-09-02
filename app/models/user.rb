class User < ActiveRecord::Base
  has_many :activities

  def switch_email_notification
    update_attribute :receive_email_notification, !receive_email_notification
  end

  def generate_email_notification_token
    update_attribute :email_exercise_token, SecureRandom.uuid
  end

  def clear_email_notification_token
    update_attribute :email_exercise_token, nil
  end

  def email_activity_token_by_activity_type(activity_type)
    "#{email_exercise_token}_#{activity_type.id}"
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.username = auth.extra.raw_info.username
      user.email = auth.info.email || auth.extra.raw_info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def self.all_want_receive_mail_notification
    where(receive_email_notification: true).
    where.not(id: all_marked_activity_yesterday.select('users.id'))
  end

  def self.all_marked_activity_yesterday
    joins(:activities).
    where(receive_email_notification: true, activities: { date: Date.yesterday})
  end
end
