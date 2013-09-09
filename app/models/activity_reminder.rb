class ActivityReminder
  
  def self.mark_by_token(params)
    token = pass_token_to_hash(params)
    return  false unless valid_token?(token)

    user = User.find_by(email_exercise_token: token[:key])
    yesterday = Date.today.prev_day

    # already was marked by user
    return false if UserActivity.done_with_this_type_on_this_date?(user, token[:activity_type_id], yesterday)

    activity = UserActivity.create(user, { date: yesterday, activity_type_id: token[:activity_type_id]})
    if activity
      user.clear_email_notification_token
    end
    activity
  end

  private
    def self.pass_token_to_hash(params)
      raw_token = params.split("_")
      return false unless raw_token.size == 3

      { date: raw_token[0], key: raw_token[1], activity_type_id: raw_token[2] }
    end

    def self.valid_token?(token)
      return false unless token.is_a?(Hash)
      return false unless token[:date] == Date.today.prev_day.to_s
      return false unless ActivityType.exists?(id: token[:activity_type_id])
      return false unless User.exists?(email_exercise_token: token[:key])
      true
    end
end