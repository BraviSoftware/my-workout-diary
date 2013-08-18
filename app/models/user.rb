class User < ActiveRecord::Base
  has_many :activities

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
